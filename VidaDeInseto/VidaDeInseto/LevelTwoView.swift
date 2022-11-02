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
            
            VStack{
                Button(action: {
                    self.alertIsPresented = true
                }, label: {
                    Image("balloon")
                })
                .frame(width: 80, height: 80, alignment: .center)
                .padding()
                .foregroundColor(.clear)
                .offset(x: 50)
                .alert(isPresented: $alertIsPresented, content: {
                    Alert(title: Text("Teste de alert"), message: Text("Textinho da dica aqui llalalalalalal"), dismissButton: .default(Text("Vamos lá!")))
                })
                Image("mushroom")
                    .scaleEffect(setZoom(magnification: magnificationLevel))
                    .gesture(MagnificationGesture().updating($magnificationLevel, body: { value, state, _ in
                        state = value
                    }) .onEnded({ value in
                        withAnimation {self.zoomLevel = minZoom
                        }
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
        LevelTwoView(nextLevel: .constant(1))
    }
}
