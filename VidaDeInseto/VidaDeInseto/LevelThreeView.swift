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
                if night{
                    Image("moon")
                } else {
                    Image("sun")
                }
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
                Image("sad-mushroom")
            }.onChange(of: scenePhase) { newPhase in
                if (newPhase == .active) {
                    print("Active -- \(UIScreen.main.brightness)")
                    if UIScreen.main.brightness == CGFloat(0){
                        print("ganhou!")
                        night = true
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
