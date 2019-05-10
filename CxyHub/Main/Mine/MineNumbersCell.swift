//
//  MineNumbersCell.swift
//  CxyHub
//
//  Created by caony on 2019/5/10.
//  Copyright © 2019年 cj. All rights reserved.
//

import UIKit

class MineNumbersCell: UITableViewCell, MineCellProtocol {
    
    var itemsView:[MineNumberItem] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        for index in 0..<3 {
            let itemView = MineNumberItem(frame: .zero)
            itemView.backgroundColor = UIColor(red: CGFloat(index) * 0.1, green: CGFloat(index) * 0.1, blue: CGFloat(index) * 0.1, alpha: 1.0)
            itemsView.append(itemView)
            contentView.addSubview(itemView)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var index = 0
        for item in itemsView {
            item.frame = CGRect(x: CGFloat(index) * bounds.width/3, y: 0, width: bounds.width/3, height: bounds.height)
            index += 1
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(model: MineUser) {
        
    }

}

class MineNumberItem : UIView {
    var textLabel:UILabel = UILabel(frame: .zero)
    var numberLabel:UILabel = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        textLabel.textColor = UIColor.black
        textLabel.text = "Repositories"
        textLabel.font = UIFont.systemFont(ofSize: 13)
        
        numberLabel.textColor = UIColor.black
        numberLabel.text = "13"
        numberLabel.font = UIFont.systemFont(ofSize: 13)
        
        addSubview(textLabel)
        addSubview(numberLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.frame = CGRect(x: 0, y: bounds.height/2, width: bounds.width, height: bounds.height/2)
        numberLabel.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height/2)
    }
}
