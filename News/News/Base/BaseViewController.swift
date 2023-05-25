//
//  BaseViewController.swift
//  News
//
//  Created by Ratchapol Pattarakanoksiri on 24/5/2566 BE.
//

import UIKit
import NVActivityIndicatorView

class BaseViewController: UIViewController {
    var activityIndicatorView: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        addActivityIndicatorView()
    }
    
    private func addActivityIndicatorView() {
        activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 60), type: .ballClipRotate, color: Constants.bluePrimaryColor, padding: nil)
                activityIndicatorView.center = view.center
                view.addSubview(activityIndicatorView)
    }
}
