//
//  DetailViewController.swift
//  CxyHub
//
//  Created by caony on 2019/5/13.
//  Copyright © 2019年 cj. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController {
    
    private var client:DetailClient = DetailClient()
    
    private var detail:Detail?
    
    private var htmlLabel:DTAttributedTextView = DTAttributedTextView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        weak var weakSelf = self
        client.fetch { (detail) in
            weakSelf?.detail = detail
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    

}
