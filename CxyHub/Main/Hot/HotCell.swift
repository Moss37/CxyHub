//
//  HotCell.swift
//  CxyHub
//
//  Created by caony on 2019/5/7.
//  Copyright © 2019年 cj. All rights reserved.
//

import UIKit
import Kingfisher

class HotCell: UITableViewCell {
    
    var avatarView:UIImageView = UIImageView(frame: .zero)
    var repoNameLabel:UILabel = UILabel(frame: .zero)
    var descLabel:UILabel = UILabel(frame: .zero)
    var todayStarLabel:UILabel = UILabel(frame: .zero)
    var langColorView:UIView = UIView(frame: .zero)
    var langLabel:UILabel = UILabel(frame: .zero)
    var starIconView:UIImageView = UIImageView(frame: .zero)
    var starLabel:UILabel = UILabel(frame: .zero)
    var forkIconView:UIImageView = UIImageView(frame: .zero)
    var forkLabel:UILabel = UILabel(frame: .zero)
    var moreButton:UIButton = UIButton(type: .custom)
    var addedStarsLabel:UILabel = UILabel(frame: .zero)
    var bulidByLabel:UILabel = UILabel(frame: .zero)
    private var avatars:[UIImageView] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarView.frame = CGRect(x: 20, y: 20, width: 0, height: 0)
        repoNameLabel.frame = CGRect(x: avatarView.frame.maxX + 0, y: 10, width: bounds.width - avatarView.frame.maxX*2 - 20, height: 14)
        let height = descLabel.sizeThatFits(CGSize(width: bounds.width - 40, height: CGFloat.greatestFiniteMagnitude)).height
        descLabel.frame = CGRect(x: 20, y: repoNameLabel.frame.maxY + 5, width: bounds.width - 40, height: height)
        todayStarLabel.frame = CGRect(x: 20, y: descLabel.frame.maxY, width: bounds.width - 40, height: 14)
        langColorView.frame = CGRect(x: 20, y: todayStarLabel.frame.maxY + 5, width: 14, height: 14)
        langColorView.layer.cornerRadius = 8
        langColorView.layer.masksToBounds = true
        let langWidth = langLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: 16)).width
        langLabel.frame = CGRect(x: langColorView.frame.maxX + 5, y: langColorView.frame.minY, width: langWidth, height: 16)
        starIconView.frame = CGRect(x: langLabel.frame.maxX + 10, y: langColorView.frame.minY, width: 16, height: 16)
        let starWidth = starLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: 16)).width
        starLabel.frame = CGRect(x: starIconView.frame.maxX + 5, y: langColorView.frame.minY, width: starWidth, height: 16)
        
        forkIconView.frame = CGRect(x: starLabel.frame.maxX + 10, y: langColorView.frame.minY, width: 16, height: 16)
        let forkWidth = forkLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: 16)).width
        forkLabel.frame = CGRect(x: forkIconView.frame.maxX + 5, y: langColorView.frame.minY, width: forkWidth, height: 16)
        bulidByLabel.frame = CGRect(x: forkLabel.frame.maxX + 10, y: langColorView.frame.minY, width: 40, height: 16)
        var index = 0
        for item in avatars {
            let originX = bulidByLabel.frame.maxX + 5 + CGFloat(index * 20 + index * 5)
            item.frame = CGRect(x: originX, y: forkLabel.frame.minY - 4, width: 20, height: 20)
            item.layer.cornerRadius = 4
            item.layer.masksToBounds = true
            index += 1
        }
        bulidByLabel.isHidden = avatars.count == 0
    }

    private func setupSubviews() {
        avatarView.layer.cornerRadius = 10
        avatarView.layer.masksToBounds = true
        contentView.addSubview(avatarView)
        
        repoNameLabel.textColor = UIColor.blue
        repoNameLabel.font = UIFont.systemFont(ofSize: 13)
        contentView.addSubview(repoNameLabel)
        
        descLabel.textColor = UIColor.gray
        descLabel.font = UIFont.systemFont(ofSize: 11)
        descLabel.numberOfLines = 0
        contentView.addSubview(descLabel)
        
        todayStarLabel.textColor = UIColor.orange
        todayStarLabel.font = UIFont.systemFont(ofSize: 11)
        contentView.addSubview(todayStarLabel)
        
        langColorView.backgroundColor = UIColor.green
        langColorView.layer.cornerRadius = 5
        langColorView.layer.masksToBounds = true
        contentView.addSubview(langColorView)
        
        langLabel.textColor = UIColor.black
        langLabel.font = UIFont.systemFont(ofSize: 11)
        contentView.addSubview(langLabel)
        
        starIconView.image = UIImage(named: "star_16")
        contentView.addSubview(starIconView)
        starLabel.textColor = UIColor.black
        starLabel.font = UIFont.systemFont(ofSize: 11)
        contentView.addSubview(starLabel)
        
        forkIconView.image = UIImage(named: "fork")
        contentView.addSubview(forkIconView)
        
        forkLabel.textColor = UIColor.black
        forkLabel.font = UIFont.systemFont(ofSize: 11)
        contentView.addSubview(forkLabel)
        
        moreButton.setImage(UIImage(named: ""), for: .normal)
        moreButton.addTarget(self, action: #selector(moreAction), for: .touchUpInside)
        contentView.addSubview(moreButton)
        
        addedStarsLabel.textColor = UIColor.white
        addedStarsLabel.font = UIFont.systemFont(ofSize: 9)
        contentView.addSubview(addedStarsLabel)
        
        bulidByLabel.textColor = UIColor.black
        bulidByLabel.font = UIFont.systemFont(ofSize: 11)
        bulidByLabel.text = "Built by"
        contentView.addSubview(bulidByLabel)
    }
    
    @objc
    private func moreAction() {
        
    }
    
    func bind(_ model:HotItem) {
        repoNameLabel.text = model.repo
        descLabel.text = model.desc
        todayStarLabel.text = model.added_stars
        langLabel.text = model.lang
        starLabel.text = model.stars
        forkLabel.text = model.forks
        for img in avatars {
            img.removeFromSuperview()
        }
        avatars.removeAll()
        for img in model.avatars {
            let imageView = UIImageView(frame: .zero)
            let resource:HotResource = HotResource()
            resource.cacheKey = img
            imageView.kf.setImage(with: resource)
            contentView.addSubview(imageView)
            avatars.append(imageView)
        }
    }
    
    func height(for model:HotItem) ->CGFloat {
        var totalHeight:CGFloat = 15
        let repoNameHeight:CGFloat = 14
        descLabel.text = model.desc
        let descHeight:CGFloat = descLabel.sizeThatFits(CGSize(width: UIScreen.main.bounds.width - 40, height: CGFloat.greatestFiniteMagnitude)).height
        let todayStarHeight:CGFloat = 14
        let langHeight:CGFloat = 16 + 5 + 5
        totalHeight += repoNameHeight
        totalHeight += descHeight
        totalHeight += todayStarHeight
        totalHeight += langHeight
        return totalHeight
    }
}

class HotResource: Resource {
    var cacheKey: String  = ""
    
    var downloadURL: URL {
        return URL(string: cacheKey) ?? URL(string: "www.baidu.com")!
    }
    
    
}
