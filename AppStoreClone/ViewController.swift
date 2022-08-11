//
//  ViewController.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/11.
//

import UIKit

class ViewController: UIViewController {

    lazy var loginView = LoginView(frame: view.frame)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = loginView
    }


}

