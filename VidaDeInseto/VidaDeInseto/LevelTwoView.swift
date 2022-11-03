//
//  LevelTwoView.swift
//  VidaDeInseto
//
//  Created by mcor on 26/10/22.
//

import SwiftUI

struct LevelTwoView: View {
    @Binding var nextLevel: Int
    
    var body: some View {
        VStack{
            PinchGestureView(nextLevel: $nextLevel)
        }
    }
}

struct PinchGestureView: View {
    
    private let minZoom: CGFloat = 1.00
    private let maxZoom: CGFloat = 2.00
    
    
    @GestureState private var magnificationLevel: CGFloat = 1
    @State private var zoomLevel: CGFloat = 1
    @Binding var nextLevel: Int
    @State private var alertIsPresented = false
    @State private var didPinch = false
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
            
            Image("plant2")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fit)
                .offset(x:-15)
            
            VStack{
                Button(action: {
                    self.alertIsPresented = true
                }, label: {
                    Image("balloon2")
                })
                .frame(width: 80, height: 80, alignment: .center)
                .padding()
                .foregroundColor(.clear)
                .offset(x: 80, y: 80)
                .alert(isPresented: $alertIsPresented, content: {
                    Alert(title: Text("Vamos escovar os dentes? "), message: Text("Txai não está muito afim de abrir a boca, será que você pode dar uma forcinha?"), dismissButton: .default(Text("Vamos lá!")))
                })
                Image(didPinch ? "happy-mushroom" : "angry-mushroom")
                    .resizable()
                    .frame(width: screenSize.width * 0.5, height: screenSize.width * 0.5)
                    .offset(y:100)
                    .scaleEffect(setZoom(magnification: magnificationLevel))
                    .gesture(MagnificationGesture().updating($magnificationLevel, body: { value, state, _ in
                        state = value
                    }) .onEnded({ value in
                        withAnimation {self.zoomLevel = minZoom
                        }
                        didPinch = true
                        victoryPlayer?.play()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5){
                            nextLevel += 1
                        }
                        
                        
                    }))
                
            }
        }
        
    }
    
    func setZoom(magnification: CGFloat) -> CGFloat {
        return max(min(self.zoomLevel * magnification, self.maxZoom), self.minZoom)
    }
}


struct LevelTwoView_Previews: PreviewProvider {
    static var previews: some View {
        LevelTwoView(nextLevel: .constant(3))
    }
}
