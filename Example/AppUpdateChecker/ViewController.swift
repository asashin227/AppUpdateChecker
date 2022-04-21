//
//  ViewController.swift
//  AppUpdateChecker
//
//  Created by asashin227 on 10/18/2017.
//  Copyright (c) 2017 asashin227. All rights reserved.
//

import UIKit
import AppUpdateChecker

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // This example is always error
        // because this example have Bundle Identifier is not found on AppStore.
        
        
    }
  
    @IBOutlet weak var textField: UITextField!
    @IBAction func didTap(_ sender: Any) {
        AppUpdateChecker().conferm(bundleId: textField.text ?? "") {
            result in
            switch result {
            case .existUpdate(let version, let releaseDate, let storeScheme):
                print("Now available version: \(version)")
                print("Release Date: \(releaseDate)")
                print("DL from hare: \(storeScheme.absoluteString)")
            case .noUpdate:
                print("Current version is newest")
            case .error(let error):
                print("error: \(error)")
            }
        }
    }
}

