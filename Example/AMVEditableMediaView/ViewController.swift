//
//  ViewController.swift
//  AMVEditableMediaView
//
//  Created by zorroseph on 04/23/2018.
//  Copyright (c) 2018 zorroseph. All rights reserved.
//

import UIKit
import AMVEditableMediaView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Photo Capture"
        
        let vc = AMVEditableMediaViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

