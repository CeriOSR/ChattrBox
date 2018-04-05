//
//  AVAudioModels.swift
//  ChattrBox
//
//  Created by Rey Cerio on 2018-04-04.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import AVFoundation

class AudioModels: NSObject, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
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
        } catch let err {
            print(err)
            return
        }
    }
    
    
}
