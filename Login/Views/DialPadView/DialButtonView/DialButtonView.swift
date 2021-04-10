//
//  DialButtonView.swift
//  Dial Pad
//
//  Created by Alexsandre kikalia on 11/19/20.
//

import UIKit

protocol DialButtonViewDelegate: AnyObject {
    func dialButtonViewDidTapButton(_ sender: DialButtonView)
}




class DialButtonView : BaseReusableView{
    
    weak var delegate: DialButtonViewDelegate? {
        didSet {
            setup()
        }
    }
    
    @IBOutlet weak var buttonView: UIButton!

    
    override func setup() {
        buttonView.layer.cornerRadius = buttonView.frame.height / 2
        buttonView.layer.masksToBounds = true
    }

    func setTitle(line1: String?, line2: String?){
        if let title = line1 , let description = line2{
            //center both lines
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .center
            
            //add center attribute with font for both lines
            let attrTitle = [NSMutableAttributedString.Key.font: UIFont(name: "Arial", size: 30.0)! ,
                             NSMutableAttributedString.Key.paragraphStyle: paragraph]
            let stringTitle = NSMutableAttributedString(string: title + "\n", attributes: attrTitle)
            
            
            let attrDescr = [NSMutableAttributedString.Key.font: UIFont(name: "Arial", size: 13.0)!,
                             NSMutableAttributedString.Key.paragraphStyle: paragraph]
            let stringDescr = NSMutableAttributedString(string: description, attributes: attrDescr)
            
            stringTitle.append(stringDescr)
            buttonView?.setAttributedTitle(stringTitle, for: [])
        }
    }

    func roundButton(){
        buttonView.layer.cornerRadius = buttonView.frame.height / 2
        buttonView.layer.masksToBounds = true
    }

    @IBAction func handleButtonTap() {
        delegate?.dialButtonViewDidTapButton(self)
    }

    
    
}


