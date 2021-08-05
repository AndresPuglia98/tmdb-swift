//
//  LoginViewController.swift
//  moovyApp
//
//  Created by José Andrés Puglia on 8/3/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameInputTextField: UITextField!
    @IBOutlet weak var passwordInputTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func handleGenerateTokenResponse(result: Result<RequestTokenResponse, Error>) -> Void {
        switch result {
        case .success(let generateTokenResponse):
            if(generateTokenResponse.success) {
                APIClient.shared.validateUser(username: self.usernameInputTextField.text!, password: self.passwordInputTextField.text!, requestToken: generateTokenResponse.requestToken ?? "", onCompletion: handleValidateUserResponse)
            }
        case .failure(let error):
            print(error)
        }
    }
    
    func handleValidateUserResponse(result: Result<RequestTokenResponse, Error>) -> Void  {
        switch result {
        case .success(let validateUserResponse):
            if(validateUserResponse.success) {
                APIClient.shared.createSession(requestToken: validateUserResponse.requestToken ?? "", onCompletion: handleCreateSessionResponse)
            }
        case .failure(let error):
            print(error)
        }
    }
    
    
    func handleCreateSessionResponse(result: Result<SessionTokenResponse, Error>) -> Void {
        switch result {
        case .success(let createSessionResponse):
            if (createSessionResponse.success){
                UserDefaults.standard.set(createSessionResponse.sessionId, forKey: "sessionId")
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                
                // This is to get the SceneDelegate object from the view controller
                // then call the change root view controller function to change to main tab bar
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
            }
        case .failure(let error):
            print(error)
        }
    }
    
    func performLogin() -> Void {
        APIClient.shared.generateToken(onCompletion: handleGenerateTokenResponse)
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        performLogin()
    }
}
