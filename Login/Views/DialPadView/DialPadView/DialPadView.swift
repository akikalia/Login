//
//  DialPadView.swift
//  Dial Pad
//
//  Created by Alexsandre kikalia on 11/20/20.
//

import UIKit


protocol DialPadViewDelegate : AnyObject {
    func callButtonDidTap(_ sender: DialPadView)
    func backspaceButtonDidTap(_ sender: DialPadView)
    func dialButtonDidTap(_ sender: DialPadView, buttonId: String? )
}

class DialPadView : BaseReusableView{
    
    @IBOutlet var collectionOfViews: Array<DialButtonView>!
    @IBOutlet var callButton: CallButtonView!
    @IBOutlet var backspaceButton: BackspaceButtonView!
    
    weak var delegate : DialPadViewDelegate?
    
    override func setup() {
        
//        setDescriptions()
        setTitles()
        setDelegate()
        backspaceButton.delegate = self
        callButton.delegate = self
    }

    func setTitles(){
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let descriptions = "   " + alphabet + "   " + " + " + "   "
        var i = 1
        var startIndex = descriptions.index(descriptions.startIndex, offsetBy: 0)
        for view in collectionOfViews{
            let offset = i == 7 || i == 9 ? 4 : 3
            let endIndex    =   descriptions.index(startIndex, offsetBy: offset)
            let substring = descriptions[startIndex..<endIndex]
            var line1 : String
            if i == 10{
                line1 =  "#"
            }else if i == 11{
                line1 =  "0"
            }else if i == 12{
                line1 = "*"
            }else{
                line1 = String(i)
            }
            view.setTitle(line1: line1, line2: String(substring))
            startIndex = descriptions.index(startIndex, offsetBy: offset)
            i+=1
        }
    }
    
    func setRoundButtons(){
        collectionOfViews.forEach { (DialButtonView) in
            DialButtonView.roundButton()
        }
        callButton.roundButton()
    }
    
    func setDelegate(){
        collectionOfViews.forEach { (DialButtonView) in
            DialButtonView.delegate = self
        }
    }
}

extension DialPadView : DialButtonViewDelegate{

    func dialButtonViewDidTapButton(_ sender: DialButtonView){
        let str = sender.buttonView.titleLabel?.text
        if let str = str{
            let endIndex = str.index(str.startIndex, offsetBy: 1)
            let substring = str[str.startIndex..<endIndex]
            delegate?.dialButtonDidTap(self, buttonId: String(substring))
        }
    }
}


extension DialPadView : CallButtonViewDelegate{

    func callButtonViewDidTapButton(_ sender: CallButtonView){
        delegate?.callButtonDidTap(self)
    }
}


extension DialPadView : BackspaceButtonViewDelegate{
    
    func backspaceButtonViewDidTapButton(_ sender: BackspaceButtonView){
        delegate?.backspaceButtonDidTap(self)
    }
}
