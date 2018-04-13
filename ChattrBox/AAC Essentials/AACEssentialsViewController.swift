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
    @IBOutlet weak var aACCollectionView: UICollectionView!
    @IBOutlet weak var textToSpeechTxtFld: UITextField!
    @IBOutlet weak var readButtonItem: UIButton!
    @IBOutlet weak var addButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
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
        cell.delegate = self
        if let sortedACCEssentials = aCCEssentials?.sorted(byKeyPath: "name") {
            let aCCEssential = sortedACCEssentials[indexPath.item]
            cell.aCCNameLbl.text = aCCEssential.name
            if let imageFileName = aCCEssential.imageFileName {
                cell.aCCImageView.loadImageFromFileNameString(fileName: imageFileName)
            } else {
                cell.aCCImageView.image = #imageLiteral(resourceName: "NoImage")
            }
        }
        cell.deleteBGViewItem.layer.cornerRadius = cell.deleteBGViewItem.bounds.width / 2
        cell.deleteBGViewItem.layer.masksToBounds = true
        cell.deleteBGViewItem.isHidden = !cell.isEditing
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
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        addButtonItem.isEnabled = !editing
        readButtonItem.isEnabled = !editing
        if let indexPaths = aACCollectionView?.indexPathsForVisibleItems {
            for indexPath in indexPaths {
                let cell = aACCollectionView?.cellForItem(at: indexPath) as! AACEssentialsCollectionViewCell
                cell.isEditing = editing
            }
        }
    }
}

extension AACEssentialsViewController: AACEssentialsCellDelegate {
    func deleteCell(_ cell: AACEssentialsCollectionViewCell) {
        if let indexPath = self.aACCollectionView?.indexPath(for: cell) {
            if let sortedActivities = aCCEssentials?.sorted(byKeyPath: "name") {
                let item = sortedActivities[indexPath.item]
                chattrRealm.deleteItems(item)
                DispatchQueue.main.async {
                    self.aACCollectionView?.reloadData()
                }
            }
        }
    }
}

class AACEssentialsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var deleteBGViewItem: UIVisualEffectView!
    @IBOutlet weak var aCCImageView: UIImageView!
    @IBOutlet weak var aCCNameLbl: UILabel!
    var delegate : AACEssentialsCellDelegate?
    var isEditing: Bool = false {
        didSet{
            deleteBGViewItem.isHidden = !isEditing
        }
    }
    
    @IBAction func deleteButtonDidTap(_ sender: Any) {
        delegate?.deleteCell(self)
    }
}

protocol AACEssentialsCellDelegate {
    func deleteCell(_ cell: AACEssentialsCollectionViewCell)
}
