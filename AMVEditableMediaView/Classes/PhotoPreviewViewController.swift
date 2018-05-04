//
//  PhotoPreviewViewController.swift
//  AMVEditableMediaView
//
//  Created by Fernando Ortiz on 4/5/18.
//

import UIKit

open class PhotoPreviewViewController: UIViewController {

    // MARK: -
    @IBOutlet weak var photoImageView: UIImageView!
    
    // MARK: - Attributes -
    public let photo: UIImage
    
    // MARK: - Life cycle -
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Result"
        
        self.configurePhotoImageView()
        self.configureNavigationBar()
    }
    
    // MARK: - Init -
    public init(photo: UIImage) {
        self.photo = photo
        let bundle = Bundle(for: PhotoPreviewViewController.self)
        super.init(nibName: "PhotoPreviewViewController", bundle: bundle)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration -
    open func configurePhotoImageView() {
        self.photoImageView.image = photo
    }
    
    open func configureNavigationBar() {
        let closeBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(closeBarButtonItemPressed))
        self.navigationItem.rightBarButtonItem = closeBarButtonItem
    }
    
    // MARK: - Actions -
    @objc func closeBarButtonItemPressed() {
        self.dismiss(animated: true, completion: nil)
    }
}
