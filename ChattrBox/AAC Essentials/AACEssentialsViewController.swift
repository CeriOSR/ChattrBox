//
//  AACEssentialsViewController.swift
//  ChattrBox
//
//  Created by Rey Cerio on 2018-04-05.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit
import AVFoundation
import RealmSwift

class AACEssentialsViewController: UIViewController {
    
    let cellId = "cellId"
    let controllerId = "Essentials"
    let audioModels = AudioModels()
    var aCCEssentials : Results<Items>?
    let chattrRealm = ChattrRealm()
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
        aCCEssentials = chattrRealm.fetchAndFilter(controllerId)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.tintAdjustmentMode = .normal
        self.navigationController?.navigationBar.tintAdjustmentMode = .automatic
    }
    
    @IBAction func readButtonDidTap(_ sender: UIButton) {
        
        guard let textString = textToSpeechTxtFld.text else {return}
        audioModels.playTextToSpeed(textString)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destController : AddItemViewController = segue.destination as! AddItemViewController
        destController.fromId = self.controllerId
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let textString = textToSpeechTxtFld.text {
            audioModels.playTextToSpeed(textString)
            textField.resignFirstResponder()
        }
        return true
    }
}

extension AACEssentialsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if aCCEssentials != nil {
            return (aCCEssentials?.count)!
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AACEssentialsCollectionViewCell
        if let sortedACCEssentials = aCCEssentials?.sorted(byKeyPath: "name") {
            let aCCEssential = sortedACCEssentials[indexPath.item]
            cell.aCCNameLbl.text = aCCEssential.name
            if let imageFileName = aCCEssential.imageFileName {
                cell.aCCImageView.loadImageFromFileNameString(fileName: imageFileName)
            } else {
                cell.aCCImageView.image = #imageLiteral(resourceName: "NoImage")
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0, height: 140.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let sorted = aCCEssentials?.sorted(byKeyPath: "name") {
            let accEssential = sorted[indexPath.item]
            var finalText = ""
            guard let name = accEssential.name else {return}
            if let text = textToSpeechTxtFld.text {
//                textToSpeechTxtFld.text = textToSpeechTxtFld.text?.stringByAppendingPathComponent(path: "\(name)")
                finalText = text + " " + name
                textToSpeechTxtFld.text = finalText
            } else {
                textToSpeechTxtFld.text = textToSpeechTxtFld.text?.stringByAppendingPathComponent(path: "\(name)")
            }
        }
    }
}

class AACEssentialsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var aCCImageView: UIImageView!
    @IBOutlet weak var aCCNameLbl: UILabel!
    
}
