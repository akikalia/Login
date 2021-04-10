//
//  AuthentificationFields.swift
//  Login
//
//  Created by Alexsandre kikalia on 12/10/20.
//

import UIKit




protocol InputViewDelegate: AnyObject {
    func inputViewActive(_ sender: InputView)
    func inputViewInactive(_ sender: InputView)
    func inputViewSetupPrimaryColor(_ sender: InputView) -> UIColor
    func inputViewSetupSecondaryColor(_ sender: InputView) -> UIColor
    
}

class InputView : BaseReusableView{
    weak var delegate: InputViewDelegate? {
        didSet {
            primaryColor  = delegate?.inputViewSetupPrimaryColor(self) ?? .red
            secondaryColor = delegate?.inputViewSetupSecondaryColor(self) ?? .white
            setup()
        }
    }
    
    @IBOutlet var textInputView: UITextField!
    
    @IBOutlet var labelView: UILabel!
    @IBOutlet var iconView: UIButton!
    @IBOutlet var borderView: UIView!
    @IBOutlet var hiddenPassView: UIButton!
    @IBOutlet var labelActiveConstraint:NSLayoutConstraint!
    @IBOutlet var textActiveConstraint:NSLayoutConstraint!
    @IBOutlet var labelInactiveConstraint:NSLayoutConstraint!
    @IBOutlet var textInactiveConstraint:NSLayoutConstraint!
  
    var primaryColor = UIColor.red// UIColor.init(red: 58/255, green: 96/255, blue: 252/255, alpha: 1)
    var secondaryColor = UIColor.white//UIColor.init(red: 245/255, green: 245/255, blue: 250/255, alpha: 1)
    
    override func setup() {
        borderView.backgroundColor = secondaryColor
        
        labelView.backgroundColor = secondaryColor
        
        textInputView.borderStyle = UITextField.BorderStyle.none
        iconView.isHidden = true
        textInputView.delegate = self
        
        textActiveConstraint.isActive = false
        labelActiveConstraint.isActive = false
        contentView.sendSubviewToBack(borderView)
        labelView.textColor = primaryColor
        textInputView.textColor = primaryColor
        hiddenPassView.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.backgroundTapEdit(_:)))
        labelView.addGestureRecognizer(tap)
        borderView.addGestureRecognizer(tap)
    }
    
    func setImage(name: String){
        iconView.setImage(UIImage(systemName: name), for: .normal)
        iconView.backgroundColor = UIColor.init(white: 0, alpha: 0)
        iconView.setTitleColor(primaryColor, for: .normal)
        iconView.isHidden = false
    }
    
    func setText(text: String){
        textInputView.text = text
    }
    
    func turnOnBorder(){
        borderView.layer.borderWidth = 2
    }
    
    func turnOffBorder(){
        borderView.layer.borderWidth = 0
    }
    
    
    func getText() -> String?{
        return textInputView.text
    }
    
    
    func setTitle(title: String?){
        labelView.text = title
    }
    func setType(isSecure: Bool){
        textInputView.isSecureTextEntry = isSecure
        if isSecure{
            hiddenPassView.isHidden = false
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        borderView.layer.masksToBounds = true
        borderView.layer.cornerRadius = contentView.frame.height / 6
        borderView.layer.borderColor = primaryColor.cgColor
    }
    
    @IBAction func showHideToggle() {
        textInputView.isSecureTextEntry = !textInputView.isSecureTextEntry
    }
    

    @objc
    func backgroundTapEdit(_ sender: UITapGestureRecognizer? = nil){
        textInputView.becomeFirstResponder()
    }
    
    @IBAction func tapEdit(){
        textInputView.becomeFirstResponder()
        
    }
}
extension InputView: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        turnOnBorder()
        textInactiveConstraint.isActive = false
        labelInactiveConstraint.isActive = false
        textActiveConstraint.isActive = true
        labelActiveConstraint.isActive = true
        
        delegate?.inputViewActive(self)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        turnOffBorder()
        
        textActiveConstraint.isActive = false
        labelActiveConstraint.isActive = false
        textInactiveConstraint.isActive = true
        labelInactiveConstraint.isActive = true
    
        delegate?.inputViewInactive(self)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        contentView.endEditing(true)
        return true
    }
}

