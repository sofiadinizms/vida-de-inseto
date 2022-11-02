//
//  AudioManager.swift
//  VidaDeInseto
//
//  Created by mcor on 31/10/22.
//

import Foundation
import AVKit

var audioPlayer: AVAudioPlayer?

func playSounds(_ soundFileName : String, _ numLoops : Int) -> AVAudioPlayer?{
    guard let soundURL = Bundle.main.url(forResource: soundFileName, withExtension: nil) else {
        fatalError("Unable to find \(soundFileName) in bundle")
    }

    do {
    
        audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
        audioPlayer?.numberOfLoops = numLoops
        
    } catch {
        print(error.localizedDescription)
    }
    
    return audioPlayer
}
