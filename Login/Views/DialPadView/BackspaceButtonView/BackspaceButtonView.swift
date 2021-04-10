//
//  BackspaceButtonView.swift
//  Dial Pad
//
//  Created by Alexsandre kikalia on 11/19/20.
//

import UIKit

protocol BackspaceButtonViewDelegate: AnyObject {
    func backspaceButtonViewDidTapButton(_ sender: BackspaceButtonView)
}




class BackspaceButtonView : BaseReusableView{
    
    weak var delegate: BackspaceButtonViewDelegate?
    
    @IBOutlet var buttonView: UIButton!

    
    override func setup() {
    }
    

    @IBAction func handleButtonTap() {
        delegate?.backspaceButtonViewDidTapButton(self)
    }

    
    
}


