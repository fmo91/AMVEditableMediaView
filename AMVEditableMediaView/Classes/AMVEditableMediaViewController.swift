//
//  AMVEditableMediaViewController.swift
//  AMVEditableMediaView
//
//  Created by admin on 24/4/18.
//

import UIKit

public class AMVEditableMediaViewController: UIViewController {

    public init() {
        let bundle = Bundle(for: AMVEditableMediaViewController.self)
        super.init(nibName: "AMVEditableMediaViewController", bundle: bundle)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
