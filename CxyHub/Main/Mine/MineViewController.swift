//
//  MineViewController.swift
//  CxyHub
//
//  Created by caony on 2019/5/6.
//  Copyright © 2019年 cj. All rights reserved.
//

import UIKit
import AttributedMarkdown
import DTCoreText
import EFMarkdown

typealias MineCoreText = (_ element:DTHTMLElement)->Void

enum MineCell {
    case user
    case other
    case setting
}

class MineViewController: BaseTableViewController {
    
    private let client = MineClient()
    private var user:MineUser?
    private var adapters:[String:MineAdapter] = [:]
    private var htmlParser:GHMarkdownParser = GHMarkdownParser()
    private var coreText:NSAttributedString?
    private var htmlLabel:DTAttributedTextView = DTAttributedTextView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        request()
    }
    
    private func request() {
        if Login.shared.hasLogin {
            weak var weakSelf = self
            client.fetchUser { (user) in
                weakSelf?.user = user
                weakSelf?.update()
            }
        }
    }
    
    private func update() {
        if let user = self.user {
            Login.shared.user = user
            let userAdapter = MineAdapter()
            userAdapter.section = MineConstants.userSection
            userAdapter.cellClass = MineProfileCell.self
            userAdapter.rowHeight = MineConstants.userRowHeight
            userAdapter.mineRows = [user] as [MineRowProtocol]
            adapters["\(userAdapter.section)"] = userAdapter
            
            var textLabelValues = [user.company ,user.location ,user.email, user.blog]
            textLabelValues = textLabelValues.filter { (string) -> Bool in
                return string.count > 0
            }
            var items:[MineOther] = []
            for item in textLabelValues {
                var other = MineOther()
                other.title = item
                items.append(other)
            }
            let otherAdapter = MineAdapter()
            otherAdapter.section = MineConstants.otherSection
            otherAdapter.cellClass = MineOtherCell.self
            otherAdapter.rowHeight = MineConstants.otherRowHeight
            otherAdapter.headerHeight = 20
            otherAdapter.cellType = .other
            otherAdapter.mineRows = items
            adapters["\(otherAdapter.section)"] = otherAdapter
            
            let settingValues = ["Setting","About", "Feedback"]
            var settingItems:[MineOther] = []
            for item in settingValues {
                var other = MineOther()
                other.title = item
                settingItems.append(other)
            }
            let settingAdapter = MineAdapter()
            settingAdapter.section = MineConstants.settingSection
            settingAdapter.cellClass = MineOtherCell.self
            settingAdapter.rowHeight = MineConstants.otherRowHeight
            settingAdapter.headerHeight = 20
            settingAdapter.accessoryType = .disclosureIndicator
            settingAdapter.cellType = .setting
            settingAdapter.mineRows = settingItems
            adapters["\(settingAdapter.section)"] = settingAdapter
            
            tableView.reloadData()
            
            let content = "IyB6aHVpc2h1c2hlbnFpCgohW1BsYXRmb3JtXShodHRwczovL2ltZy5zaGll\nbGRzLmlvL2JhZGdlL3BsYXRmb3Jtcy1pT1MlMjA4LjArJTIwJTdDJTIwbWFj\nT1MlMjAxMC4xMCslMjAlN0MlMjB0dk9TJTIwOS4wKyUyMCU3QyUyMHdhdGNo\nT1MlMjAyLjArLTMzMzMzMy5zdmcpCgpbIVtMYW5ndWFnZV0oaHR0cHM6Ly9p\nbWcuc2hpZWxkcy5pby9iYWRnZS9sYW5ndWFnZS1Td2lmdC1icmlnaHRncmVl\nbi5zdmc/c3R5bGU9ZmxhdCldKGh0dHBzOi8vZGV2ZWxvcGVyLmFwcGxlLmNv\nbS9PYmplY3RpdmUtQykKWyFbTGljZW5zZV0oaHR0cDovL2ltZy5zaGllbGRz\nLmlvL2JhZGdlL2xpY2Vuc2UtTUlULWxpZ2h0Z3JleS5zdmc/c3R5bGU9Zmxh\ndCldKGh0dHA6Ly9taXQtbGljZW5zZS5vcmcpCgoqKumHh+eUqFN3aWZ06K+t\n6KiA77yM5Lu/6L+95Lmm56We5Zmo5YGa55qE77yM5Li76KaB5piv57uD5Lmg\n6ZiF6K+75Zmo55qE5LiA5Lqb5oqA5pyv77yM5YyF5ous5Lu/55yf6ZiF6K+7\n562J44CC5LiN5pat5pu05paw5LitLi4uLi4uKioKCioqMjAxNzA2MDfvvJrm\nnKzmrKHlip/og73lj5jmm7TvvJrlop7liqDkuabmnrbliKDpmaTvvIznvJPl\nrZjvvIzkv67lpI3kuIDkupvnvLrpmbcqKgoKKioyMDE3MDYxMjog5pys5qyh\n5Yqf6IO95Y+Y5pu077ya5aKe5Yqg5byA5bGP5bm/5ZGK77yM5aKe5Yqg6aaW\n5qyh5a6J6KOF5paw54m55oCn77yM5o6o6I2Q5Lmm57GN562JKioKCioqMjAx\nNzA4MDjvvJrmnKzmrKHlip/og73lj5jmm7TvvJrlhYXliIbliKnnlKhTd2lm\ndOivreiogOeJueaAp++8jOaVtOWQiEFQSe+8jOW8leWFpUNvY29hUG9kc+eu\noeeQhuS4ieaWueW6kyoqCgoqKjIwMTcxMjE5OiDmnKzmrKHlip/og73lj5jm\nm7Q6IOmAgumFjWlQaG9uZSBYKioKCioqMjAxODAxMTA6IOacrOasoeWKn+iD\nveWPmOabtO+8muS/ruWkjeS6hmlPUyAxMSDkuIrpmIXor7vlmajmloflrZfk\nuI3mmL7npLrpl67popgqKgoKKioyMDE4MDQwMzog5pys5qyh5Yqf6IO95Y+Y\n5pu077ya6ZiF6K+75Zmo5YaF5a2Y5LyY5YyW77yM5YaF5a2Y5L+d5oyB56iz\n5a6aKioKCioqMjAxODA2MDY6IOacrOasoeWKn+iDveWPmOabtDogU3dpZnTo\nr63oqIDmm7TmlrDoh7M0LjAqKgoKKioyMDE4MDcyNjog5pys5qyh5Yqf6IO9\n5Y+Y5pu0OiDpmIXor7vlmajku6PnoIHkvJjljJYqKgoKKioyMDE4MDgwMzog\n5pys5qyh5Yqf6IO95Y+Y5pu0OiDlop7liqDmnKzlnLDkuabnsY3pmIXor7vl\nip/og70qKgoKKioyMDE4MDgxOTog5pys5qyh5Yqf6IO95Y+Y5pu0OiDov73k\nuabnpL7ljLrmlrDlop7lpKfph4/lip/og70s5L6n5ruR6I+c5Y2V5paw5aKe\n5aSn6YeP5Yqf6IO9KioKCioqMjAxODA4Mjg6IOacrOasoeWKn+iDveWPmOab\ntDog6K+E6K665Yy65aKe5Yqg5Zu+5paH5re35o6S5Yqf6IO9LOato+ehruWx\nleekuuivhOiuuuS4reeahOWbvueJh+WPiumTvuaOpSoqCgoqKjIwMTgwOTE5\nOiDmnKzmrKHlip/og73lj5jmm7Q6IOmAgumFjVN3aWZ0NC4y5Y+KWGNvZGUx\nMCoqCgoqKjIwMTgxMDAyOiDmnKzmrKHlip/og73lj5jmm7Q6IOa3u+WKoOaJ\ni+acuueZu+W9leWPiuS4ieaWueeZu+W9leWKn+iDvSoqCgoqKjIwMTgxMDI1\nOiDmnKzmrKHlip/og73lj5jmm7Q6IOa3u+WKoOeZu+W9leWQjuS5puaetuS/\noeaBr+WQjOatpSoqCgoqKjIwMTgxMTAyOiDmnKzmrKHlip/og73lj5jmm7Q6\nIOa3u+WKoOiHquWKqOetvuWIsOWKn+iDvSzov5vlhaVBUFDljbPlj6/oh6rl\niqjnrb7liLAqKgoKKioyMDE5MDEwMjog5pys5qyh5Yqf6IO95Y+Y5pu0OiDk\nv67lpI3kuabmnrbliLfmlrDljaHpob8m6ZiF6K+76L+H55qE5Lmm57GN572u\n6aG2KGJyYW5jaCBkZXZfZGIpKioKCioqMjAxODAzMjHvvJrmnKzmrKHlip/o\ng73lj5jmm7TvvJrkv67lpI3lpJrkuKrnvLrpmbfvvIzliIbnsbvpobXpnaLk\nvJjljJYqKgoKKioyMDE5MDQwOe+8muacrOasoeWKn+iDveWPmOabtO+8muS/\nruWkjeS5puaetuWIoOmZpOS5puexjeaXtuivr+WIoOaVtOS4quS5puaetuea\nhOmXrumimCoqCgotLS0tCgoqKuS7heS+m+WtpuS5oOS6pOa1ge+8jOivt+WL\nv+eUqOS6juWVhuS4mueUqOmAlCoqCgojIyBSZXF1aXJlbWVudHMKCi0gaU9T\nIDkuMCsgLyBtYWNPUyAxMC4xMysgLyB0dk9TIDkuMCsgLyB3YXRjaE9TIDIu\nMCsKLSBYY29kZSAxMC4wKwotIFN3aWZ0IDQuMisKCk1haW4gZGV2ZWxvcG1l\nbnQgb2Ygemh1aXNodXNoZW5xaSBvbG55IHN1cHBvcnQgU3dpZnQgNC4wKy4K\nCiMjI0hlcmUgeW91IGNhbiBzZWUgYmxvdy4KCgo9PT09PT09CgojIyPmlYjm\nnpzlm77lpoLkuIvvvJoKCgo8IS0tIVt6aHVpc2h1c2hlbnFpXSh6aHVpc2h1\nc2hlbnFpLnBuZykKIVt6aHVpc2hlbnFpaW5nXShpbWFnZXMvcXNfYm9va3No\nZWxmLnBuZykKIVt6aHVpc2hlbnFpaW1nXShpbWFnZXMvcXNfcmVhZGVyLnBu\nZykKIVt6aHVpc2hlbnFpaW1nXShpbWFnZXMvcXNfcmVhZGVyTWFpbi5wbmcp\nCiFbemh1aXNoZW5xaWltZ10oaW1hZ2VzL3FzX2NoYW5nZVNvdXJjZS5wbmcp\nLS0+Cgo8aW1nIHNyYz0iaW1hZ2VzL3FzX2Jvb2tzaGVsZi5wbmciIHdpZHRo\nPSIyMCUiIGhlaWdodD0iMjAlIiAvPjxpbWcgc3JjPSJpbWFnZXMvcXNfcmVh\nZGVyLnBuZyIgd2lkdGg9IjIwJSIgaGVpZ2h0PSIyMCUiIC8+PGltZyBzcmM9\nImltYWdlcy9xc19yZWFkZXJNYWluLnBuZyIgd2lkdGg9IjIwJSIgaGVpZ2h0\nPSIyMCUiIC8+PGltZyBzcmM9ImltYWdlcy9xc19jaGFuZ2VTb3VyY2UucG5n\nIiB3aWR0aD0iMjAlIiBoZWlnaHQ9IjIwJSIgLz4KPGltZyBzcmM9ImltYWdl\ncy9TaW11bGF0b3IgU2NyZWVuIFNob3QgLSBpUGhvbmUgWCAtIDIwMTgtMDgt\nMjIgYXQgMTguMzYuMDYucG5nIiB3aWR0aD0iMjAlIiBoZWlnaHQ9IjIwJSIg\nLz4KPGltZyBzcmM9ImltYWdlcy9TaW11bGF0b3IgU2NyZWVuIFNob3QgLSBp\nUGhvbmUgWCAtIDIwMTgtMDgtMjIgYXQgMTguMzguNDMucG5nIiB3aWR0aD0i\nMjAlIiBoZWlnaHQ9IjIwJSIgLz4KPGltZyBzcmM9ImltYWdlcy9TaW11bGF0\nb3IgU2NyZWVuIFNob3QgLSBpUGhvbmUgWCAtIDIwMTgtMDgtMjIgYXQgMTgu\nMzYuMDkucG5nIiB3aWR0aD0iMjAlIiBoZWlnaHQ9IjIwJSIgLz4KPGltZyBz\ncmM9ImltYWdlcy9TaW11bGF0b3IgU2NyZWVuIFNob3QgLSBpUGhvbmUgWCAt\nIDIwMTgtMDgtMjIgYXQgMTguMzYuMTIucG5nIiB3aWR0aD0iMjAlIiBoZWln\naHQ9IjIwJSIgLz4KPGltZyBzcmM9ImltYWdlcy9TaW11bGF0b3IgU2NyZWVu\nIFNob3QgLSBpUGhvbmUgWCAtIDIwMTgtMDgtMjIgYXQgMTguMzYuMTgucG5n\nIiB3aWR0aD0iMjAlIiBoZWlnaHQ9IjIwJSIgLz4KPGltZyBzcmM9ImltYWdl\ncy9TaW11bGF0b3IgU2NyZWVuIFNob3QgLSBpUGhvbmUgWCAtIDIwMTgtMDgt\nMjIgYXQgMTguMzYuMjMucG5nIiB3aWR0aD0iMjAlIiBoZWlnaHQ9IjIwJSIg\nLz4KPGltZyBzcmM9ImltYWdlcy9TaW11bGF0b3IgU2NyZWVuIFNob3QgLSBp\nUGhvbmUgWCAtIDIwMTgtMDgtMjIgYXQgMTguMzYuMjcucG5nIiB3aWR0aD0i\nMjAlIiBoZWlnaHQ9IjIwJSIgLz4KPGltZyBzcmM9ImltYWdlcy9TaW11bGF0\nb3IgU2NyZWVuIFNob3QgLSBpUGhvbmUgWCAtIDIwMTgtMDgtMjIgYXQgMTgu\nMzYuMzgucG5nIiB3aWR0aD0iMjAlIiBoZWlnaHQ9IjIwJSIgLz4KPGltZyBz\ncmM9ImltYWdlcy9TaW11bGF0b3IgU2NyZWVuIFNob3QgLSBpUGhvbmUgWCAt\nIDIwMTgtMDgtMjIgYXQgMTguMzYuNDYucG5nIiB3aWR0aD0iMjAlIiBoZWln\naHQ9IjIwJSIgLz4KPGltZyBzcmM9ImltYWdlcy9TaW11bGF0b3IgU2NyZWVu\nIFNob3QgLSBpUGhvbmUgWCAtIDIwMTgtMDgtMjIgYXQgMTguMzYuNTQucG5n\nIiB3aWR0aD0iMjAlIiBoZWlnaHQ9IjIwJSIgLz4KPGltZyBzcmM9ImltYWdl\ncy9TaW11bGF0b3IgU2NyZWVuIFNob3QgLSBpUGhvbmUgWCAtIDIwMTgtMDgt\nMjIgYXQgMTguMzcuMDQucG5nIiB3aWR0aD0iMjAlIiBoZWlnaHQ9IjIwJSIg\nLz4KPGltZyBzcmM9ImltYWdlcy9TaW11bGF0b3IgU2NyZWVuIFNob3QgLSBp\nUGhvbmUgWCAtIDIwMTgtMDgtMjIgYXQgMTguMzcuMDkucG5nIiB3aWR0aD0i\nMjAlIiBoZWlnaHQ9IjIwJSIgLz4KPGltZyBzcmM9ImltYWdlcy9TaW11bGF0\nb3IgU2NyZWVuIFNob3QgLSBpUGhvbmUgWCAtIDIwMTgtMDgtMjIgYXQgMTgu\nMzguMjEucG5nIiB3aWR0aD0iMjAlIiBoZWlnaHQ9IjIwJSIgLz4KPGltZyBz\ncmM9ImltYWdlcy9TaW11bGF0b3IgU2NyZWVuIFNob3QgLSBpUGhvbmUgWCAt\nIDIwMTgtMDgtMjIgYXQgMTguMzguMjgucG5nIiB3aWR0aD0iMjAlIiBoZWln\naHQ9IjIwJSIgLz4KPGltZyBzcmM9ImltYWdlcy9TaW11bGF0b3IgU2NyZWVu\nIFNob3QgLSBpUGhvbmUgWCAtIDIwMTgtMDgtMjIgYXQgMTguMzguMzMucG5n\nIiB3aWR0aD0iMjAlIiBoZWlnaHQ9IjIwJSIgLz4KCgojIyBDb250YWN0CgpG\nb2xsb3cgYW5kIGNvbnRhY3QgbWUgb24gbWFpbCBbMjI1MjA1NTM4MkBxcS5j\nb21dKGh0dHBzOi8vbWFpbC5xcS5jb20vKS4gSWYgeW91IGZpbmQgYW4gaXNz\ndWUsIGp1c3QgW29wZW4gYSB0aWNrZXRdKGh0dHBzOi8vZ2l0aHViLmNvbS9O\nb3J5Q2FvL3podWlzaHVzaGVucWkvaXNzdWVzL25ldykuIFB1bGwgcmVxdWVz\ndHMgYXJlIHdhcm1seSB3ZWxjb21lIGFzIHdlbGwuCgojIyBMaWNlbnNlCgp6\naHVpc2h1c2hlbnFpIGlzIHJlbGVhc2VkIHVuZGVyIHRoZSBNSVQgbGljZW5z\nZS4gU2VlIExJQ0VOU0UgZm9yIGRldGFpbHMuCgoK\n"
            let decodeStr = String(base64: content)
//            let ode = content.fromBase64()
            var path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
            path.append("/REMDME.md")
            let text = try? String(contentsOfFile: path) ?? ""
            let htmlStr = htmlParser.htmlString(fromMarkdownString: text)
            let html = try? EFMarkdown().markdownToHTML(text ?? "", options: EFMarkdownOptions.safe)

            let data = html?.data(using: .utf8)
            let attr = NSMutableAttributedString(htmlData: data, options:coreTextOptions(), documentAttributes: nil)
            tableView.isHidden = true
            htmlLabel.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 700)
            htmlLabel.attributedString = coreTextAttr()
            view.addSubview(htmlLabel)
            
            print(attr)
            
            
        }
    }
    
    var callback:MineCoreText!
    private func coreTextAttr() ->NSAttributedString? {
        // Create attributed string from HTML
        let maxImageSize = CGSize(width: self.view.bounds.size.width - 20.0, height: self.view.bounds.size.height - 20.0)
        
        // example for setting a willFlushCallback, that gets called before elements are written to the generated attributed string
        callback = { element in
            for item in element.childNodes {
                if let oneChildElement = item as? DTHTMLElement {
                    if oneChildElement.displayStyle == .inline && oneChildElement.textAttachment.displaySize.height > 2.0 * oneChildElement.fontDescriptor.pointSize {
                        oneChildElement.displayStyle = .block
                        oneChildElement.paragraphStyle.minimumLineHeight = element.textAttachment.displaySize.height
                        oneChildElement.paragraphStyle.maximumLineHeight = element.textAttachment.displaySize.height
                    }
                }
            }
        }
        var path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        path.append("/REMDME.md")
        let text = try? String(contentsOfFile: path)
        let html = try? EFMarkdown().markdownToHTML(text ?? "", options: EFMarkdownOptions.safe)
        
        let data = html?.data(using: .utf8)
        let options = [NSTextSizeMultiplierDocumentOption:1.0,
                       DTMaxImageSize:maxImageSize,
                       DTDefaultFontFamily:"Times New Roman",
                       DTDefaultLinkColor:"purple",
                       DTDefaultLinkHighlightColor:"red",
//                       DTWillFlushBlockCallBack:callback,
                       NSBaseURLDocumentOption:URL(fileURLWithPath: path)] as [String : Any]
        let attr = NSAttributedString(htmlData: data, options: options, documentAttributes: nil)
        return attr
    }
    
    private func coreTextOptions() ->[String:Any] {
        return [DTUseiOS6Attributes:true,
                DTIgnoreInlineStylesOption:true,
                DTDefaultLinkDecoration:false,
                DTDefaultLinkColor:UIColor.blue,
                DTLinkHighlightColorAttribute:UIColor.red,
                DTDefaultFontSize:15,
                DTDefaultFontFamily:"Arial",
                DTDefaultFontName:"ArialMT"
        ]
    }
    
    private func setupSubviews() {
        needsLogin = true
        navigationItem.title = "Profile"
        
        htmlParser.options = kGHMarkdownAutoLink
        htmlParser.githubFlavored = true
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return adapters.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let adapter = adapters["\(section)"] {
            return adapter.mineRows.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let adapter = adapters["\(indexPath.section)"] {
            switch adapter.cellType {
            case .user:
                let cell = tableView.qs_dequeueReusableCell(adapter.cellClass!) as! MineProfileCell
                cell.selectionStyle = .none
                cell.bind(model: adapter.mineRows[indexPath.row])
                return cell
            case .other, .setting:
                let cell = tableView.qs_dequeueReusableCell(adapter.cellClass!) as! MineOtherCell
                cell.selectionStyle = .none
                cell.accessoryType = adapter.accessoryType
                cell.bind(model: adapter.mineRows[indexPath.row])
                return cell
                
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let adapter = adapters["\(indexPath.section)"] {
            return adapter.rowHeight
        }
        return 0.01
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let adapter = adapters["\(section)"] {
            return adapter.headerHeight
        }
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let adapter = adapters["\(indexPath.section)"] {
            switch adapter.cellType {
            case .user:
                break
            case .other:
                break
            case .setting:
                
                break
            }
        }
    }
    
    override func registerCellClasses() -> Array<AnyClass> {
        return [MineProfileCell.self,MineOtherCell.self]
    }
}

class MineAdapter {

    var mineRows:[MineRowProtocol] = []
    
    var section: Int = 0
    
    var headerHeight: CGFloat = 0.01
    
    var footerHeight: CGFloat = 0.01
    
    var rowHeight: CGFloat = 0.01
    
    weak var headerView:UIView?
    
    var headerClass:UIView.Type?
    
    var cellClass:UITableViewCell.Type?
    
    var cellType:MineCell = .user
    
    weak var footerView:UIView?
    
    var accessoryType:UITableViewCell.AccessoryType = .none
    
    var selectedLang:String = ""
    
    var headerText:String = ""
    
    init(_ data:[MineRowProtocol] = []) {
        mineRows = data
    }
    
}


protocol MineRowProtocol {
    
}

struct MineConstants {
    static let userSection = 0
    static let otherSection = 1
    static let settingSection = 2
    static let userRowHeight:CGFloat = 160
    static let otherRowHeight:CGFloat = 44

    
}
