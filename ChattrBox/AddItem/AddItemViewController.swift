//
//  AddItemViewController.swift
//  Let's Chat
//
//  Created by Rey Cerio on 2018-03-30.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class AddItemViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    let realm = try! Realm()
    var fromId : String?
    var saved: Bool = false
    let chattrRealm = ChattrRealm()
    
    @IBOutlet weak var newItemImageView: UIImageView!
    @IBOutlet weak var newItemTypeLabel: UILabel!
    @IBOutlet weak var newItemNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newItemNameTextField.delegate = self
        newItemTypeLabel.text = fromId
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveItem))
        newItemImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapImage)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewWillDisappear(_ animated: Bool) {

    }

    // MARK: Handle Interactive Keyboard
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    
    // Mark: Image Handler
    
    var imageFileName = String()
    
    @objc func didTapImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = false
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            newItemImageView.image = image
        }
        self.dismiss(animated: true) {
        }
    }
    
    private func savingImage() {
        guard let image = newItemImageView.image else {return}
        var fileName = ""
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        if let name = newItemNameTextField.text {
            fileName = NSUUID().uuidString + "-\(name)-image.jpg"
            imageFileName = fileName
        } else {
            fileName = NSUUID().uuidString + "-image.jpg"
            imageFileName = fileName
        }
        let fileUrl = documentDirectory?.appendingPathComponent(fileName)
        
        let imageData = UIImageJPEGRepresentation(image, 0.3)
        do {
            try imageData?.write(to: fileUrl!)
        } catch let err {
            print("Could not write to disk", err)
        }
    }
    
    
    // MARK: - Handle Saving to Files App and Realm
    
    @objc func saveItem() {
        savingImage()
        guard let name = newItemNameTextField.text else {return}
        guard let type = newItemTypeLabel.text else {return}
        let item = Items()
        item.name = name
        item.type = type
        item.imageFileName = imageFileName
        chattrRealm.writingToRealmDB(item)
        handleSegueToTabBar()
        
    }
    
    private func handleSegueToTabBar() {
        performSegue(withIdentifier: "addItemToTabBarController", sender: self)
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
