//
//  Level4View.swift
//  VidaDeInseto
//
//  Created by aaav on 20/10/22.
//
import SwiftUI

struct LevelFourView: View {
    @Environment(\.scenePhase) var scenePhase
    
    @AppStorage("startTime") var startTimeString : String = ""
    @State var start : DateComponents = DateComponents()
    @State var end :  DateComponents = DateComponents()
    
    @State var active : Bool = false
    @State var text : String = "Tô de abuso,\npreciso de um minutinho."
    @Binding var nextLevel: Int
    @State private var alertIsPresented = false
    @State private var levelCompleted = false
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
            
            Image("left-branch")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fill)
                .offset(x:20, y: 30)
            
            Image("right-branch")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fit)
                .offset(x:0, y: -230)
        
        VStack{
//            Text(text)
            Button(action: {
                self.alertIsPresented = true
            }, label: {
                Image("balloon4")
            })
            .frame(width: 80, height: 80, alignment: .center)
            .padding()
            .foregroundColor(.clear)
            .offset(x: 80, y: 80)
            .alert(isPresented: $alertIsPresented, content: {
                Alert(title: Text("Um tempo para si é importante"), message: Text("Que tal curtir sua própria companhia um pouco? O Txai tem uma mensagem para você: \(text)"), dismissButton: .default(Text("Vamos lá!")))
            })
            Image(levelCompleted ? "happy-mushroom" : "angry-mushroom")
                .resizable()
                .frame(width: screenSize.width * 0.5, height: screenSize.width * 0.5)
                .offset(y: 100)
        }
        .onChange(of: scenePhase) { newPhase in
            if (newPhase == .active) && active {
                print("Active")
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
                let dateStart = formatter.date(from: startTimeString)
                start = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: dateStart!)
                end = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: Date.now)
                
                let diffComponents = Calendar.current.dateComponents([.second], from: start, to: end)
                
                if (diffComponents.second ?? 0 < 60){
                    text = "Já tá de volta?\nMe deixa em paz um minutinho."
                } else {
                    text = "Agora sim, bebê!\nBora dar uma subidinha!"
                    levelCompleted = true
                    victoryPlayer?.play()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5){
                        nextLevel += 1
                    }
                }
                
                
            } else if newPhase == .inactive{
                print("Inactive")
                
            } else if (newPhase == .background) && !active {
                print("Background")
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
                startTimeString = formatter.string(from: Date.now)
                active.toggle()
                
            }
        }
        
    }
    }
}
struct Level4View_Previews: PreviewProvider {
    static var previews: some View {
        LevelFourView(nextLevel: .constant(1))
    }
}
