//
//  DTImageTextAttachment+CxyHub.m
//  CxyHub
//
//  Created by caony on 2019/5/13.
//  Copyright © 2019年 cj. All rights reserved.
//

#import "DTImageTextAttachment+CxyHub.h"
#if TARGET_OS_IPHONE
#import <DTFoundation/DTAnimatedGIF.h>
#endif
#import <DTFoundation/DTBase64Coding.h>
//#import <SDWebImage/SDWebImage.h>

static NSCache *imageCache = nil;

@interface DTImageTextAttachment ()

+ (NSCache *)sharedImageCache;
- (void)_updateSizesFromImage:(DTImage *)image;

@end


@implementation DTImageTextAttachment (CxyHub)

- (void)_decodeImageFromElement:(DTHTMLElement *)element options:(NSDictionary *)options
{
    // get base URL
    NSURL *baseURL = [options objectForKey:NSBaseURLDocumentOption];
    NSString *src = [element.attributes objectForKey:@"src"];
    
    NSURL *contentURL = nil;
    
    // decode content URL
    if ([src length]) // guard against img with no src
    {
        if ([src hasPrefix:@"data:"])
        {
            NSString *cleanStr = [[src componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString:@""];
            
            NSURL *dataURL = [NSURL URLWithString:cleanStr];
            
            // try native decoding first
            NSData *decodedData = [NSData dataWithContentsOfURL:dataURL];
            
            // try own base64 decoding
            if (!decodedData)
            {
                NSRange range = [cleanStr rangeOfString:@"base64,"];
                
                if (range.length)
                {
                    NSString *encodedData = [cleanStr substringFromIndex:range.location + range.length];
                    
                    decodedData = [DTBase64Coding dataByDecodingString:encodedData];
                }
            }
            
            // if we have image data, get the default display size
            if (decodedData)
            {
                DTImage *decodedImage = [[DTImage alloc] initWithData:decodedData];
                
                // we don't know the content scale from such images, need to infer it from size in style
                NSString *styles = [element.attributes objectForKey:@"style"];
                
                // that only works if there is a style dictionary
                if (styles)
                {
                    NSDictionary *attributes = [styles dictionaryOfCSSStyles];
                    
                    NSString *widthStr = attributes[@"width"];
                    NSString *heightStr = attributes[@"height"];
                    
                    if ([widthStr hasSuffix:@"px"] && [heightStr hasSuffix:@"px"])
                    {
                        CGSize sizeAccordingToStyle;
                        
                        // those style size values are the original image size
                        sizeAccordingToStyle.width = [widthStr pixelSizeOfCSSMeasureRelativeToCurrentTextSize:0 textScale:1];
                        sizeAccordingToStyle.height = [heightStr pixelSizeOfCSSMeasureRelativeToCurrentTextSize:0 textScale:1];
                        
                        // if _orgiginal width and height are a fraction of decode image size, it must be a scaled image
                        if (sizeAccordingToStyle.width != 0 && sizeAccordingToStyle.width < decodedImage.size.width &&
                            sizeAccordingToStyle.height != 0 && sizeAccordingToStyle.height < decodedImage.size.height)
                        {
                            // determine image scale
                            CGFloat scale = round(decodedImage.size.width/sizeAccordingToStyle.width);
                            
                            // sanity check, accept from @2x - @5x
                            if (scale>=2.0 && scale<=5.0)
                            {
#if TARGET_OS_IPHONE
                                // on iOS change the scale by making a new image with same pixels
                                decodedImage = [DTImage imageWithCGImage:decodedImage.CGImage scale:scale orientation:decodedImage.imageOrientation];
#else
                                // on OS X we can set the size
                                [decodedImage setSize:sizeAccordingToStyle];
#endif
                            }
                        }
                    }
                }
                
                self.image = decodedImage;
                
                // prevent remote loading of image
                _contentURL = nil;
            }
        }
        else // normal URL
        {
            contentURL = [NSURL URLWithString:src];
            
            if(!contentURL)
            {
                src = [src stringByAddingHTMLEntities];
                contentURL = [NSURL URLWithString:src relativeToURL:baseURL];
            }
            
            if (![contentURL scheme])
            {
                // possibly a relative url
                if (baseURL)
                {
                    contentURL = [NSURL URLWithString:src relativeToURL:baseURL];
                }
                else
                {
                    // file in app bundle
                    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
                    NSString *path = [bundle pathForResource:src ofType:nil];
                    
                    if (path)
                    {
                        // Prevent a crash if path turns up nil.
                        contentURL = [NSURL fileURLWithPath:path];
                    }
                    else
                    {
                        // might also be in a different bundle, e.g. when unit testing
                        bundle = [NSBundle bundleForClass:[DTTextAttachment class]];
                        
                        path = [bundle pathForResource:src ofType:nil];
                        if (path)
                        {
                            // Prevent a crash if path turns up nil.
                            contentURL = [NSURL fileURLWithPath:path];
                        }
                    }
                }
            }
            // normal image url
            dispatch_queue_t queue = dispatch_queue_create("gcd.queue", NULL);
            // add to sync queue, this url is not correct,you may need to get it from server
            dispatch_sync(queue, ^{
//                SDWebImageDownloader * downloader = [SDWebImageDownloader sharedDownloader];
//                [downloader downloadImageWithURL:contentURL completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
//                    NSLog(@"error:%@",error);
//                }];
            });
            
            NSData * imageData = [NSData dataWithContentsOfURL:contentURL];
            UIImage * image = [[UIImage alloc] initWithData:imageData];
            self.image = image;
        }
    }
    
    // if it's a local file we need to inspect it to get it's dimensions
    if (_displaySize.width==0 || _displaySize.height==0)
    {
        DTImage *image = self.image;
        
        // let's check if we have a cached image already then we can inspect that
        if (!self.image)
        {
            image = [[DTImageTextAttachment sharedImageCache] objectForKey:[contentURL absoluteString]];
        }
        
        if (!image)
        {
            // only local files we can directly load without punishment
            if ([contentURL isFileURL])
            {
#if TARGET_OS_IPHONE
                NSString *ext = [[[contentURL lastPathComponent] pathExtension] lowercaseString];
                
                if ([ext isEqualToString:@"gif"])
                {
                    image = DTAnimatedGIFFromFile([contentURL path]);
                }
                else
#endif
                {
                    image = [[DTImage alloc] initWithContentsOfFile:[contentURL path]];
                }
            }
            
            // cache that for later
            if (image)
            {
                [[DTImageTextAttachment sharedImageCache] setObject:image forKey:[contentURL absoluteString]];
            }
        }
        
        // we have an image, so we can set the original size and default display size
        if (image)
        {
            _contentURL = nil;
            [self _updateSizesFromImage:image];
        }
    }
    
    // only remote images should have a URL
    _contentURL = contentURL;
}

@end
