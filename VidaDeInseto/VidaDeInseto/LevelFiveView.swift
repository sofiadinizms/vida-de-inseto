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
    @State private var audioPlayer: AVAudioPlayer!
    @ObservedObject private var volObserver = VolumeObserver()
    @Binding var nextLevel: Int
    @State private var alertIsPresented = false
    
//    init() {
//        
//    }
    
    var body: some View {
        
        ZStack{
            Image("sky")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fill)
                .offset(x:20)
            
            Image("tronco2")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fill)
                .offset(x:20)
            
            VStack {
                
                Text("current volume is \(volObserver.volume)")
                Button(action: {
                    self.alertIsPresented = true
                }, label: {
                    Image("balloon")
                })
                .frame(width: 80, height: 80, alignment: .center)
                .padding()
                .foregroundColor(.clear)
                .offset(x: 50, y: 10)
                .alert(isPresented: $alertIsPresented, content: {
                    Alert(title: Text("Teste de alert"), message: Text("Textinho da dica aqui llalalalalalal"), dismissButton: .default(Text("Vamos lá!")))
                })
                Image("mushroom")
                
                
            }
            .onAppear(perform: {
                
                playSounds("ForestAudio.m4a")
                
                
            })
            
            .onChange(of: volObserver.volume) { _ in
                if volObserver.volume == 1.0 {
                    print("volume máximo")
                } else if volObserver.volume == 0.0 {
                    print("volume mínimo")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5){
                        nextLevel += 1
                    }
                } else {
                    print("faz alguma coisa")
                }
                
            }
            
        }
        
        
        
    }
    
    
    struct LevelFiveView_Previews: PreviewProvider {
        static var previews: some View {
            LevelFiveView(nextLevel: .constant(1))
        }
    }
    
}
