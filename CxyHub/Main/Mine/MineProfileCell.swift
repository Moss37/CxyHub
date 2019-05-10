//
//  MineProfileCell.swift
//  CxyHub
//
//  Created by caony on 2019/5/10.
//  Copyright © 2019年 cj. All rights reserved.
//

import UIKit

protocol MineCellProtocol {
    func bind(model:MineUser)
}

class MineProfileCell: UITableViewCell, MineCellProtocol {
    
    
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
    }
    
    func bind(model: MineUser) {
        
    }
}
