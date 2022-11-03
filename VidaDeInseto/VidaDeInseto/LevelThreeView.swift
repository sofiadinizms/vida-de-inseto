//
//  LevelThreeView.swift
//  VidaDeInseto
//
//  Created by sofiadinizms on 01/11/22.
//

import SwiftUI

struct LevelThreeView: View {
    @State var brightness = UIScreen.main.brightness
    @State var night = false
    @Environment(\.scenePhase) var scenePhase
    @Binding var nextLevel: Int
    @State private var alertIsPresented = false
    let screenSize = UIScreen.main.bounds
    let victoryPlayer = playSounds("sfx_sounds_powerup16.wav", 1)
    
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
                .aspectRatio(contentMode: .fit)
                .offset(x:20)
            
            Image("plant")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fit)
                .offset(x:-15)
            
            Image("right-branch")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fill)
                .offset(x:-100, y: 260)
            
            Image("left-branch")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fill)
                .offset(x:20, y: 60)
            
            Image("right-branch")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fit)
                .offset(x:0, y: 420)
            
            VStack{
                Button(action: {
                    self.alertIsPresented = true
                }, label: {
                    Image("balloon3")
                })
                .frame(width: 80, height: 80, alignment: .center)
                .padding()
                .foregroundColor(.clear)
                .offset(x: 80, y: -20)
                .alert(isPresented: $alertIsPresented, content: {
                    Alert(title: Text("Hora da soneca"), message: Text("Txai está querendo descansar e essa luz está atrapalhando. Mostre a ele que você se importa com a qualidade do sono dele."), dismissButton: .default(Text("Vamos lá!")))
                })
                Image(night ? "happy-mushroom" : "sad-mushroom")
                    .resizable()
                    .frame(width: screenSize.width * 0.5, height: screenSize.width * 0.5)
            }.onChange(of: scenePhase) { newPhase in
                if (newPhase == .active) {
                    print("Active -- \(UIScreen.main.brightness)")
                    if UIScreen.main.brightness == CGFloat(0){
                        print("ganhou!")
                        night = true
                        victoryPlayer?.play()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5){
                            nextLevel += 1
                        }
                    }
                    
                } else if newPhase == .inactive{
                    print("Inactive")
                    
                } else if (newPhase == .background) {
                    print("Background")
                }
                
            }
        }
    }
}


struct LevelThreeView_Previews: PreviewProvider {
    static var previews: some View {
        LevelThreeView(nextLevel: .constant(1))
    }
}
