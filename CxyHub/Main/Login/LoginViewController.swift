//
//  LoginViewController.swift
//  CxyHub
//
//  Created by caony on 2019/5/6.
//  Copyright © 2019年 cj. All rights reserved.
//

import UIKit
import SnapKit
import SafariServices

typealias LoginHandler = ()->Void

class LoginViewController: BaseViewController {

    private var avatarImageView:UIImageView = UIImageView(frame: .zero)
    private var titleLabel:UILabel = UILabel(frame: .zero)
    private var descLabel:UILabel = UILabel(frame: .zero)
    private var signupButton:UIButton = UIButton(type: .custom)
    private var accessTokenButton:UIButton = UIButton(type: .custom)
    private var closeButton:UIButton = UIButton(type: .custom)
    
    var failureHandler:LoginHandler?
    var successHandler:LoginHandler?
    
    private let loginClient:LoginClient = LoginClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        addObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
    }
    
    override func viewWillLayoutSubviews() {
        avatarImageView.snp.remakeConstraints { (make) in
            make.left.equalToSuperview().offset(self.view.bounds.width/3)
            make.right.equalToSuperview().offset(-self.view.bounds.width/3)
            make.top.equalToSuperview().offset(self.view.bounds.height/3)
            make.height.equalTo(self.view.bounds.width/3)
        }
        
        titleLabel.snp.remakeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(self.avatarImageView.snp.bottom).offset(60)
            make.height.equalTo(20)
        }
        
        descLabel.snp.remakeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(20)
            make.height.equalTo(20)
        }
        
        accessTokenButton.snp.remakeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-100)
            make.height.equalTo(50)
        }
        
        signupButton.snp.remakeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(self.accessTokenButton.snp.top).offset(-20)
            make.height.equalTo(50)
        }
        
        closeButton.snp.remakeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            let statusHeight = UIApplication.shared.statusBarFrame.height
            make.top.equalToSuperview().offset(statusHeight)
            make.width.height.equalTo(44)
        }
    }
    
    private func addObservers() {
        let loginSuccessNoptification = NSNotification.Name.init(AppConstants.loginSuccessNotificationName)
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccess), name: loginSuccessNoptification, object: nil)
    }
    
    private func setupSubviews() {
        avatarImageView.image = UIImage(named: "login_avatar")
        view.addSubview(avatarImageView)
        
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.text = "Welcome to CxyHub"
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        descLabel.textColor = UIColor.gray
        descLabel.font = UIFont.systemFont(ofSize: 15)
        descLabel.text = "An open source app for open source projects."
        descLabel.textAlignment = .center
        view.addSubview(descLabel)
        
        signupButton.setTitle("Sign in with Github", for: .normal)
        signupButton.backgroundColor = UIColor(red: 0.00, green: 0.49, blue: 0.87, alpha: 1.00)
        signupButton.layer.cornerRadius = 5
        signupButton.layer.masksToBounds = true
        signupButton.addTarget(self, action: #selector(signInAction), for: .touchUpInside)
        view.addSubview(signupButton)
        
        accessTokenButton.setTitle("Sign in with Personal Token", for: .normal)
        accessTokenButton.setTitleColor(UIColor(red: 0.00, green: 0.49, blue: 0.87, alpha: 1.00), for: .normal)
        accessTokenButton.backgroundColor = UIColor.white
        accessTokenButton.layer.cornerRadius = 5
        accessTokenButton.layer.masksToBounds = true
        accessTokenButton.layer.borderColor = UIColor(red: 0.00, green: 0.49, blue: 0.87, alpha: 1.00).cgColor
        accessTokenButton.layer.borderWidth = 0.3
        accessTokenButton.addTarget(self, action: #selector(accessTokenAction), for: .touchUpInside)
        view.addSubview(accessTokenButton)
        
        closeButton.setImage(UIImage(named: "login_close"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        view.addSubview(closeButton)
    }
    
    @objc
    private func loginSuccess() {
        dismiss(animated: true, completion: nil)
        showProgress()
        weak var weakSelf = self
        loginClient.fetchAccessToken { (response) in
            weakSelf?.hideProgress()
        }
    }
    
    @objc
    private func closeAction() {
        dismiss(animated: true, completion: nil)
        failureHandler?()
    }
    
    @objc
    private func signInAction() {
        if let url = URL(string: loginClient.api.baseURLString) {
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true, completion: nil)
        }
    }
    
    @objc
    private func accessTokenAction() {
        
    }
}
