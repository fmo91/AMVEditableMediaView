//
//  AMVEditableMediaViewController.swift
//  AMVEditableMediaView
//
//  Created by admin on 24/4/18.
//

import UIKit

public class AMVEditableMediaViewController: UIViewController {

    override public func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public init() {
        let bundle = Bundle(for: AMVEditableMediaViewController.self)
        super.init(nibName: "AMVEditableMediaViewController", bundle: bundle)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("SUPER ERROR, DESTRUYENDO TODO EN 3...")
    }
}
