//
//  AddItemViewController.swift
//  Let's Chat
//
//  Created by Rey Cerio on 2018-03-30.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import RealmSwift

class AddItemViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, AVAudioPlayerDelegate, AVAudioRecorderDelegate, UITextFieldDelegate {
    
    var fromId : String?
    var saved: Bool = false
    
    
    @IBOutlet weak var newItemImageView: UIImageView!
    @IBOutlet weak var newItemTypeLabel: UILabel!
    @IBOutlet weak var newItemNameTextField: UITextField!
    @IBOutlet weak var soundSlider: UISlider!
    @IBOutlet weak var permissionDeniedLbl: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newItemNameTextField.delegate = self
        newItemTypeLabel.text = fromId
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveItem))
        newItemImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapImage)))
        permissionDeniedLbl.isHidden = true
        setupRecorder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        do {
            try FileManager.default.removeItem(at: getFileUrl())
        } catch {
            return
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: Handle Slider
    
    var timer = Timer()
    var counter: Float = 0
    var isRunning: Bool = false
    private func handleTimer() {
        if !isRunning {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            isRunning = true
        }
    }
    
    @objc func updateTimer() {
        if counter < 3 {
            counter += 1
            soundSlider.value = counter
            soundRecorder?.record()
            recordButton.setTitle("Stop", for: .normal)
            playButton.isEnabled = false
            
        } else {
            timer.invalidate()
            counter = 0
            soundSlider.value = 0
            isRunning = false
            soundRecorder?.stop()
            recordButton.setTitle("Record", for: .normal)
            playButton.isEnabled = true
        }
    }
    
    // Mark: Image Handler
    
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
        } else {
            fileName = NSUUID().uuidString + "-image.jpg"
        }
        let fileUrl = documentDirectory?.appendingPathComponent(fileName)
        let imageData = UIImageJPEGRepresentation(image, 0.3)
        do {
            try imageData?.write(to: fileUrl!)
        } catch let err {
            print("Could not write to disk", err)
        }
    }
    
    //    // Mark: Sound Handler
    var soundPlayer : AVAudioPlayer?
    var soundRecorder : AVAudioRecorder?
    var fileName = ""
 
    @IBAction func soundRecordButton(_ sender: UIButton) {
        handleTimer()
//        if sender.titleLabel?.text == "Record" {
//            handleTimer()
////            self.soundRecorder?.record()
////            sender.setTitle("Stop", for: .normal)
////            self.playButton.isEnabled = false
//        } else {
//            soundRecorder?.stop()
//            sender.setTitle("Record", for: .normal)
//            playButton.isEnabled = true
//        }
        
    }
    
    @IBAction func soundPlayer(_ sender: UIButton) {
        setupPlayer()
        if sender.titleLabel?.text == "Play" {
            recordButton.isEnabled = false
            sender.setTitle("Stop", for: .normal)
            soundPlayer?.play()
        } else {
            recordButton.isEnabled = true
            sender.setTitle("Play", for: .normal)
            soundPlayer?.stop()
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        playButton.isEnabled = true
        recordButton.isEnabled = true
        recordButton.setTitle("Record", for: .normal)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playButton.isEnabled = true
        playButton.setTitle("Play", for: .normal)
        recordButton.isEnabled = true
    }
    
    func setupRecorder() {
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        do {
            soundRecorder = try AVAudioRecorder(url: getFileUrl(), settings: settings)
            soundRecorder?.delegate = self
            soundRecorder?.prepareToRecord()
        } catch let err {
            print(err)
        }
        
    }
    
    private func getCacheDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        guard let first = paths.first else {return "no path"}
        return first
    }
  
    private func makePermanentCopy() {
        do {
            try FileManager.default.copyItem(at: getFileUrl(), to: getPermanentFileUrl())
        } catch let err {
            print(err)
        }
    }
    
    private func getPermanentFileUrl() -> URL {
        if let name = newItemNameTextField.text {
            fileName = NSUUID().uuidString + "-\(name)" + ".m4a"
        } else {
            fileName = NSUUID().uuidString + ".m4a"
        }
        let path = getCacheDirectory().stringByAppendingPathComponent(path: fileName)
        let fileUrl = URL(fileURLWithPath: path)
        return fileUrl
    }
    
    private func getFileUrl() -> URL {
        fileName = "soundBite.m4a"
        let path = getCacheDirectory().stringByAppendingPathComponent(path: fileName)
        let fileUrl = URL(fileURLWithPath: path)
        return fileUrl
    }
    
    private func setupPlayer() {
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: getFileUrl())
            soundPlayer?.delegate = self
            soundPlayer?.prepareToPlay()
            soundPlayer?.volume = 1.0
        } catch let err {
            print(err)
        }
    }
    
    // MARK: - Handle Saving to Files App and Realm
    @objc func saveItem() {
        savingImage()
        makePermanentCopy()
        handleSegueToTabBar()
    }
    
    private func handleSegueToTabBar() {
        performSegue(withIdentifier: "addItemToTabBarController", sender: self)
        //
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
