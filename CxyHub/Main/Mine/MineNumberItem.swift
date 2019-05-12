//
//  MineNumbersCell.swift
//  CxyHub
//
//  Created by caony on 2019/5/10.
//  Copyright © 2019年 cj. All rights reserved.
//

import UIKit

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
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 13)
        
        numberLabel.textColor = UIColor.black
        numberLabel.text = "13"
        numberLabel.textAlignment = .center
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
