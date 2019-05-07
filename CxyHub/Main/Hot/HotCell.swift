//
//  HotCell.swift
//  CxyHub
//
//  Created by caony on 2019/5/7.
//  Copyright © 2019年 cj. All rights reserved.
//

import UIKit

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
        let height = descLabel.sizeThatFits(CGSize(width: bounds.width - avatarView.frame.maxX*2 - 20, height: CGFloat.greatestFiniteMagnitude)).height
        descLabel.frame = CGRect(x: 20, y: repoNameLabel.frame.maxY + 5, width: bounds.width - avatarView.frame.maxX*2 - 20, height: height)
        todayStarLabel.frame = CGRect(x: 20, y: descLabel.frame.maxY, width: bounds.width - avatarView.frame.maxX*2 - 20, height: 14)
        
        self.frame = CGRect(x: 0, y: 0, width: bounds.width, height: todayStarLabel.frame.maxY)
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
        
        todayStarLabel.textColor = UIColor.gray
        todayStarLabel.font = UIFont.systemFont(ofSize: 11)
        contentView.addSubview(todayStarLabel)
        
        langColorView.backgroundColor = UIColor.green
        langColorView.layer.cornerRadius = 5
        langColorView.layer.masksToBounds = true
        contentView.addSubview(langColorView)
        
        langLabel.textColor = UIColor.black
        langLabel.font = UIFont.systemFont(ofSize: 11)
        contentView.addSubview(langLabel)
        
        contentView.addSubview(starIconView)
        langLabel.textColor = UIColor.black
        langLabel.font = UIFont.systemFont(ofSize: 11)
        
        contentView.addSubview(langLabel)
        
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
    }
    
    @objc
    private func moreAction() {
        
    }
    
    func bind(_ model:HotItem) {
        repoNameLabel.text = model.repo
        descLabel.text = model.desc
        todayStarLabel.text = model.added_stars
    }
}
