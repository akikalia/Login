//
//  AuthentificationFields.swift
//  Login
//
//  Created by Alexsandre kikalia on 12/10/20.
//

import UIKit
//
protocol AuthBarViewDelegate : AnyObject {
    func authBarInputFieldInactive(_ sender: AuthBarView)
    func authBarInputFieldActive(_ sender: AuthBarView)
    func authBarViewSetColorScheme(_ sender: AuthBarView) -> (UIColor, UIColor)
    func authBarSignUpButtonDidTap(_ sender: AuthBarView)
    func authBarLoginButtonDidTap(_ sender: AuthBarView)
    func authBarForgotButtonDidTap(_ sender: AuthBarView)
}

class AuthBarView : BaseReusableView{
    weak var delegate: AuthBarViewDelegate? {
        didSet {
            (primaryColor, secondaryColor) = delegate?.authBarViewSetColorScheme(self) ?? (.red, .white)
            setup()
        }
    }
    
    @IBOutlet weak var loginButtonView: SubmitButtonView!
    @IBOutlet weak var signUpButtonView: SubmitButtonView!
    
    @IBOutlet weak var emailInputView: InputView!
    @IBOutlet weak var passwordInputView: InputView!
    
    
    var primaryColor = UIColor.blue
    var secondaryColor = UIColor.white
    override func setup(){
        loginButtonView.delegate = self
        signUpButtonView.delegate = self
        emailInputView.delegate = self
        passwordInputView.delegate = self
        signUpButtonView.setBackgroundColor(color: secondaryColor)
        signUpButtonView.setTitleColor(color: primaryColor)
        loginButtonView.setTitle(text: "Login")
        signUpButtonView.setTitle(text: "Sign up")
        emailInputView.setTitle(title: " email ")
        passwordInputView.setTitle(title: " password ")
        emailInputView.setType(isSecure: false)
        passwordInputView.setType(isSecure: true)
        emailInputView.setImage(name: "envelope")
        passwordInputView.setImage(name: "lock")
        
        emailInputView.setText(text: "test@mail.com")
        passwordInputView.setText(text: "1234")
    }
    func getEmail() -> String?{
        return emailInputView.getText()
    }
    func getPassword() -> String?{
        return passwordInputView.getText()
    }
    @IBAction func handleForgotButtonTap(){
        delegate?.authBarForgotButtonDidTap(self)
    }
}

extension AuthBarView: InputViewDelegate{
    func inputViewActive(_ sender: InputView){
        delegate?.authBarInputFieldActive(self)
    }
    func inputViewInactive(_ sender: InputView){
        delegate?.authBarInputFieldInactive(self)
    }
    func inputViewSetupPrimaryColor(_ sender: InputView) -> UIColor{
       return primaryColor
    }
    func inputViewSetupSecondaryColor(_ sender: InputView) -> UIColor{
        return secondaryColor
    }
}

extension AuthBarView: SubmitButtonViewDelegate{
    func submitButtonViewDidTapButton(_ sender: SubmitButtonView, buttonId: String?) {
        if buttonId == "Login"{
            delegate?.authBarLoginButtonDidTap(self)
        }else{
            delegate?.authBarSignUpButtonDidTap(self)
        }
    }
    func submitButtonViewSetupPrimaryColor(_ sender: SubmitButtonView) -> UIColor{
        return primaryColor
    }
    func submitButtonViewSetupSecondaryColor(_ sender: SubmitButtonView) -> UIColor{
        return secondaryColor
    }
    
    
}



