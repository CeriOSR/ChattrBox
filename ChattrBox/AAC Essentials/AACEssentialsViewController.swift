//
//  AACEssentialsViewController.swift
//  ChattrBox
//
//  Created by Rey Cerio on 2018-04-05.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit
import AVFoundation

class AACEssentialsViewController: UIViewController {
    
    
    @IBOutlet weak var textToSpeechTxtFld: UITextField!
    @IBOutlet weak var readButtonItem: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textToSpeechTxtFld.delegate = self
        if !(textToSpeechTxtFld.text?.isEmpty)! {
            readButtonItem.isEnabled = false
        } else {
            readButtonItem.isEnabled = true
        }
    }
    
    @IBAction func readButtonDidTap(_ sender: UIButton) {
        
        guard let textString = textToSpeechTxtFld.text else {return}
        let utterance = AVSpeechUtterance(string: textString)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }
}

extension AACEssentialsViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textToSpeechTxtFld.text! as NSString).replacingCharacters(in: range, with: string)
        if !text.isEmpty {
            readButtonItem.isEnabled = true
        } else {
            readButtonItem.isEnabled = false
        }
        return true
    }
}

//let utterance = AVSpeechUtterance(string: string)
//utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
//
//let synth = AVSpeechSynthesizer()
//synth.speak(utterance)
//Remember to import AVFoundation
