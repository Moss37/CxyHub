//
//  MineOtherCell.swift
//  CxyHub
//
//  Created by caonongyun on 2019/5/11.
//  Copyright © 2019年 cj. All rights reserved.
//

import UIKit

class MineOtherCell: UITableViewCell,MineCellProtocol {
    func bind(model: MineRowProtocol) {
        guard let item = model as? MineOther else {
            return
        }
        textLabel?.text = item.title
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
