//
//  ViewController.swift
//  Dial Pad
//
//  Created by Alexsandre kikalia on 11/19/20.
//

import UIKit

class DialPadViewController: UIViewController{

    @IBOutlet var pad : DialPadView!
    @IBOutlet var textfield : UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        pad.delegate = self
        textfield.isUserInteractionEnabled = false
    }
    
    override func viewWillLayoutSubviews() {
        pad.setRoundButtons()
    }
    
}

extension DialPadViewController : DialPadViewDelegate{
    func callButtonDidTap(_ sender: DialPadView){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CallViewController")
        if let vc = vc{
            self.present(vc, animated: true, completion: nil)
        }
    }
    func backspaceButtonDidTap(_ sender: DialPadView){
        if let str = textfield.text?.dropLast(){
            textfield.text = String.init(str)
        }
    }
    func dialButtonDidTap(_ sender: DialPadView, buttonId: String? ){
        textfield.text?.append(buttonId!)
    }
}
