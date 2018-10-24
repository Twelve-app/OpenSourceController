//
//  OpenSourceViewController.swift
//  Pods
//
//  Created by Florian Gabach on 05/02/2017.

import UIKit

final class OpenSourceViewController: UIViewController {
    
    // MARK: - Var
    
    fileprivate var showCloseButton: Bool

    fileprivate var licences: [LicenceFile]
    
    fileprivate var config: OpenSourceControllerConfig
    
    fileprivate lazy var loadingController = {
       return LoadingViewController(configuration: config)
    }()
    
    fileprivate lazy var closeButton: UIBarButtonItem = {
        let closeButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(self.closePicker))
        closeButton.tintColor = self.config.uiConfig.closeButtonColor ?? UIColor.black
        return closeButton
    }()
    
    // MARK: - Lifecyle
    
    init(licences: [LicenceFile], showCloseButton: Bool, configuration: OpenSourceControllerConfig) {
        self.licences = licences
        self.showCloseButton = showCloseButton
        self.config = configuration
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.config.title
        
        self.prepareCloseButton()
        self.prepareStyle()
        
        self.add(self.loadingController)
        self.prepareLicences()
    }
    
    // MARK: - Prepare
    
    fileprivate func prepareStyle() {
        // Apply navigation bar tint color if needed
        if let tintColor = self.config.uiConfig.barTintColor {
            self.navigationController?.navigationBar.barTintColor = tintColor
        }
        
        // Apply navigation bar text color if needed
        if let textColor = self.config.uiConfig.titleColor {
            let attribut = [NSAttributedString.Key.foregroundColor: textColor]
            self.navigationController?.navigationBar.titleTextAttributes = attribut
        }
    }
    
    fileprivate func prepareLicences() {
        LicenceLoader.downloadLicences(licences: licences, config: config) { [weak self] in
            guard let strongSelf = self else { return }
            let listController = LicenceListViewController(downloadedLicence: strongSelf.licences, config: strongSelf.config)
            strongSelf.loadingController.remove()
            strongSelf.add(listController)
        }
    }
    
    fileprivate func prepareCloseButton() {
        if showCloseButton {
            self.navigationItem.rightBarButtonItem = closeButton
        }
    }
    
    // MARK: - Action
    
    @objc fileprivate func closePicker() {
        self.dismiss(animated: true, completion: nil)
    }
}