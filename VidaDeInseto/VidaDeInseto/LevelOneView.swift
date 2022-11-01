//
//  LevelOneView.swift
//  VidaDeInseto
//
//  Created by sofiadinizms on 24/10/22.
//

import SwiftUI

// The notification we'll send when a shake gesture happens.
extension UIDevice {
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

//  Override the default behavior of shake gestures to send our notification instead.
extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
    }
}

// A view modifier that detects shaking and calls a function of our choosing.
struct DeviceShakeViewModifier: ViewModifier {
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
                action()
            }
    }
}

// A View extension to make the modifier easier to use.
extension View {
    func onShake(perform action: @escaping () -> Void) -> some View {
        self.modifier(DeviceShakeViewModifier(action: action))
    }
}

struct LevelOneView: View {
    
    @State private var imageShow = 0
    @State var isShaken = false
    @State private var alertIsPresented = false
    @Binding var nextLevel: Int
    
    var body: some View {
        
        ZStack{
            
            Image("background1")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fill)
            
            VStack{
                ZStack{
                    
                    FoodImageUIView(shakeAmount: $imageShow)
                    
                    Image("mushroom")
                        .onShake {
                            imageShow += 1
                            
                            if (imageShow == 2){
                                nextLevel += 1
                            }
                            
                            isShaken = true
                            print("Device shaken!")
                        }
                    if imageShow == 0 {
                        
                        Button(action: {
                            self.alertIsPresented = true
                        }, label: {
                            Image("balloon")
                        })
                        .frame(width: 80, height: 80, alignment: .center)
                        .padding()
                        .foregroundColor(.clear)
                        .offset(x: 50, y: -80)
                        .alert(isPresented: $alertIsPresented, content: {
                            Alert(title: Text("Teste de alert"), message: Text("Textinho da dica aqui llalalalalalal"), dismissButton: .default(Text("Vamos lá!")))
                        })
                        
                        
                        
                    }
                }
            }
            
        }
    }
}

struct LevelOneView_Previews: PreviewProvider {
    static var previews: some View {
        LevelOneView(nextLevel: .constant(1))
    }
}
