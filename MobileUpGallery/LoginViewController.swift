//
//  LoginViewController.swift
//  MobileUpGallery
//
//  Created by Lazzat Seiilova on 27.07.2021.
//

import UIKit

class LoginViewController: UIViewController {

    private var authenticationService: AuthenticationService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        authenticationService = AuthenticationService()
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        authenticationService.wakeUpSession()
    }
    
    
}
