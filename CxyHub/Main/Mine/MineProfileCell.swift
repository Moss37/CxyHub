//
//  MineProfileCell.swift
//  CxyHub
//
//  Created by caony on 2019/5/10.
//  Copyright © 2019年 cj. All rights reserved.
//

import UIKit
import Kingfisher

protocol MineCellProtocol {
    func bind(model:MineRowProtocol)
}

class MineProfileCell: UITableViewCell, MineCellProtocol {
    private var itemsView:[MineNumberItem] = []
    
    private var avatarView:UIImageView = UIImageView(frame: .zero)
    private var nameLabel:UILabel = UILabel(frame: .zero)
    private var descLabel:UILabel = UILabel(frame: .zero)
    private var joinTimeLabel:UILabel = UILabel(frame: .zero)

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
        avatarView.frame = CGRect(x: 20, y: 20, width: 60, height: 60)
        nameLabel.frame = CGRect(x: avatarView.frame.maxX + 15, y: 20, width: bounds.width - avatarView.frame.maxX - 15 - 20, height: 20)
        descLabel.frame = CGRect(x: avatarView.frame.maxX + 15, y: 40, width: bounds.width - avatarView.frame.maxX - 15 - 20, height: 20)
        joinTimeLabel.frame = CGRect(x: avatarView.frame.maxX + 15, y: 60, width: bounds.width - avatarView.frame.maxX - 15 - 20, height: 20)
        var index = 0
        for item in itemsView {
            item.frame = CGRect(x: CGFloat(index) * bounds.width/3, y: 100, width: bounds.width/3, height: 60)
            index += 1
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        
        avatarView.image = UIImage(named: "")
        avatarView.layer.cornerRadius = 10
        avatarView.layer.masksToBounds = true
        
        nameLabel.textColor = UIColor.blue
        nameLabel.font = UIFont.systemFont(ofSize: 13)
        
        descLabel.textColor = UIColor.gray
        descLabel.font = UIFont.systemFont(ofSize: 13)
        
        joinTimeLabel.textColor = UIColor.black
        joinTimeLabel.font = UIFont.systemFont(ofSize: 13)
        
        contentView.addSubview(avatarView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(joinTimeLabel)
        
        for _ in 0..<3 {
            let itemView = MineNumberItem(frame: .zero)
            itemsView.append(itemView)
            contentView.addSubview(itemView)
        }
    }
    
    func bind(model: MineRowProtocol) {
        guard let item = model as? MineUser else { return }
        let hotResource = HotResource()
        hotResource.cacheKey = item.avatar_url
        avatarView.kf.setImage(with: hotResource)
        nameLabel.text = "\(item.name)"
        descLabel.text = "\(item.bio)"
        joinTimeLabel.text = "Joined on \(item.created_at)"
        
        var textLabelValues:[String] = ["Repositories","Followers","Following"]
        var numLabelValues:[String] = ["\(item.public_repos)","\(item.followers)","\(item.following)"]
        var index = 0
        for item in itemsView {
            item.textLabel.text = textLabelValues[index]
            item.numberLabel.text = numLabelValues[index]
            index += 1
        }
    }
}

