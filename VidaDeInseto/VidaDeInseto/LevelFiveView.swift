//
//  LevelFiveView.swift
//  VidaDeInseto
//
//  Created by mcor on 31/10/22.
//

import SwiftUI
import AVFoundation
import MediaPlayer
import UIKit


struct LevelFiveView: View {
    @State private var forestPlayer: AVAudioPlayer!
    @ObservedObject private var volObserver = VolumeObserver()
    @Binding var nextLevel: Int
    
    var body: some View {
        
        ZStack {
            
            Text("current volume is \(volObserver.volume)")
            
            
        }
        .onAppear(perform: {
            forestPlayer = playSounds("ForestAudio.m4a", -1)
            forestPlayer.play()
        })
        
        .onChange(of: volObserver.volume) { _ in
            if volObserver.volume == 1.0 {
                print("volume máximo")
            } else if volObserver.volume == 0.0 {
                
                print("volume mínimo")
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5){
                    nextLevel += 1
                    forestPlayer?.stop()
                }
            } else {
                print("faz alguma coisa")
            }
            
        }
        
        
    }
    
    
    struct LevelFiveView_Previews: PreviewProvider {
        static var previews: some View {
            LevelFiveView(nextLevel: .constant(1))
        }
    }
    
}
