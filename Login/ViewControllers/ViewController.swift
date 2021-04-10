//
//  ViewController.swift
//  Login
//
//  Created by Alexsandre kikalia on 12/10/20.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var authBar :AuthBarView!
    
    @IBOutlet var topView :UIView!
    @IBOutlet var topTitle :UILabel!
    @IBOutlet var scrollView :UIScrollView!
    
    var primaryColor = UIColor.init(displayP3Red: 76/255, green: 91/255, blue: 244/255, alpha: 1)
    var secondaryColor =  UIColor.init(red: 245/255, green: 245/255, blue: 250/255, alpha: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
        authBar.delegate = self
        topView.backgroundColor = primaryColor
        topTitle.text = "Login"
        topTitle.textColor = .white
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc
    func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let authBarBottom = view.convert(authBar.frame.origin, to: nil).y + authBar.frame.height
            let keyboardTop = keyboardFrame.cgRectValue.origin.y
            let distance = authBarBottom - keyboardTop
            let offset = CGFloat.init(20.0)

//            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardTop, right: 0)
           
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
                    self.scrollView.contentOffset.y = distance + offset
                }, completion: nil)
            }
            
        }
    }

    @objc
    func keyboardWillHide(_ notification: Notification) {
//        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom:0, right: 0)
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
                self.scrollView.contentOffset.y = 0
            }, completion: nil)
        }
    }
    
}
extension ViewController : AuthBarViewDelegate{
    
    func authBarViewSetColorScheme(_ sender: AuthBarView) -> (UIColor, UIColor){
        return (primaryColor,secondaryColor)
    }
    
    func authBarInputFieldInactive(_ sender: AuthBarView) {
        
    }
    
    func authBarInputFieldActive(_ sender: AuthBarView) {
        
    }
    
    func authBarSignUpButtonDidTap(_ sender: AuthBarView) {
        
    }
    
    func authBarLoginButtonDidTap(_ sender: AuthBarView) {
        if let email = authBar.getEmail() , let password = authBar.getPassword() {
            if email == "test@mail.com" && password == "1234"{
                //todo: transition to previous project
                let storyboard = UIStoryboard(name: "DialPad", bundle: nil)
                let vc = storyboard.instantiateInitialViewController()! as UIViewController
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
            }
        }
        
    }
    func authBarForgotButtonDidTap(_ sender: AuthBarView) {
        
    }
}
