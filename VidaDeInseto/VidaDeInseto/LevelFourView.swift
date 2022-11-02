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
            Text(text)
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
