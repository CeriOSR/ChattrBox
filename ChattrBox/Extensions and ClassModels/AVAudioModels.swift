//
//  AVAudioModels.swift
//  ChattrBox
//
//  Created by Rey Cerio on 2018-04-04.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import AVFoundation

class AudioModels: NSObject, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    let alertModels = AlertsModels()
    let url = GetFileUrl()
    var audioPlayer = AVAudioPlayer()
    var audioRecorder = AVAudioRecorder()
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func setupPlayer(fileName: String) {
        let fileUrl = documentsUrl.appendingPathComponent(fileName)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: fileUrl)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 1.0
        } catch {
            alertModels.createAlertWithOneAction("Audio Player Not Found", message: "Try restarting the app.")
            return
        }
    }
    
    func playTextToSpeed(_ text: String) {
        let textString = text
        let utterance = AVSpeechUtterance(string: textString)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }
    
    func setupRecorder(_ url: URL) {
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        do {
            audioRecorder = try AVAudioRecorder(url: url, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
        } catch {
            alertModels.createAlertWithOneAction("Audio Recorder Not Found", message: "Try restarting the app.")
        }
    }
}
