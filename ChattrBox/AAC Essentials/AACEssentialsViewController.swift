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
    //        let tapGestureToDismissKeyboard = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
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

//        aACCollectionView.addGestureRecognizer(tapGestureToDismissKeyboard)
        
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


