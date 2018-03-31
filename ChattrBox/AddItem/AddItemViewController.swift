//
//  AddItemViewController.swift
//  Let's Chat
//
//  Created by Rey Cerio on 2018-03-30.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {

    var fromId : String?
    
    @IBOutlet weak var newItemImageView: UIImageView!
    
    @IBOutlet weak var newItemTypeLabel: UILabel!
    
    @IBOutlet weak var newItemNameTextField: UITextField!
    
    @IBOutlet weak var soundSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        newItemTypeLabel.text = fromId
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveItem))
    }

    
    @IBAction func soundRecordButton(_ sender: Any) {
        
    }
    
    @objc func saveItem() {
        print("Items are being saved....")
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
