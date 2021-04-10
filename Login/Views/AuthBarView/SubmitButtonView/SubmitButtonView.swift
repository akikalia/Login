//
//  AuthentificationFields.swift
//  Login
//
//  Created by Alexsandre kikalia on 12/10/20.
//

import UIKit



protocol SubmitButtonViewDelegate: AnyObject {
    func submitButtonViewDidTapButton(_ sender: SubmitButtonView, buttonId: String?)
    func submitButtonViewSetupPrimaryColor(_ sender: SubmitButtonView) -> UIColor
    func submitButtonViewSetupSecondaryColor(_ sender: SubmitButtonView) -> UIColor
}

class SubmitButtonView : BaseReusableView{
    weak var delegate: SubmitButtonViewDelegate? {
        didSet {
            primaryColor  = delegate?.submitButtonViewSetupPrimaryColor(self) ?? .red
            secondaryColor = delegate?.submitButtonViewSetupSecondaryColor(self) ?? .white
            
            setup()
        }
    }
    
    @IBOutlet weak var buttonView: UIButton!
    var primaryColor = UIColor.red
    var secondaryColor = UIColor.white
    
    
    override func setup() {
        buttonView.backgroundColor = primaryColor
        buttonView.setTitleColor(secondaryColor, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buttonView.layer.cornerRadius = buttonView.frame.height / 6
        buttonView.layer.masksToBounds = true
        buttonView.layer.borderWidth = 2
        buttonView.layer.borderColor = primaryColor.cgColor
    }
    func setBackgroundColor(color: UIColor){
        buttonView.backgroundColor = color
    }
    func setTitleColor(color: UIColor){
        buttonView.setTitleColor(color, for: .normal)
    }
    
    func setTitle(text: String){
        buttonView.setTitle(text, for: .normal)
    }
    
    @IBAction func handleButtonTap() {
        delegate?.submitButtonViewDidTapButton(self, buttonId: buttonView.currentTitle)
    }


}

