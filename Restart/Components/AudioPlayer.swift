//
//  AudioPlayer.swift
//  Restart
//
//  Created by Meet Patel on 2023-11-07.
//

import Foundation
import AVFoundation


var audioPlayer: AVAudioPlayer?

func playSound(sound:String, type:String){
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do {
        audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        audioPlayer?.play()
        } catch  {
            print("Error Playing Sound")
        }
    }
}
