//
//  HomeScreen.swift
//  Restart
//
//  Created by Meet Patel on 2023-11-06.
//

import SwiftUI

struct HomeScreen: View {
    
    @AppStorage("onboarding") var onBoarding: Bool = false
    
    @State private var isAnimating:Bool = false
    
    var body: some View {
        VStack(spacing:20){
            Spacer()
            ZStack{
                CircleGroupView(ShapeColor: Color.gray, ShapeOpacity: 0.2)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y:isAnimating ? 35: -35)
                    .animation(.easeIn(duration: 4).repeatForever(), value: isAnimating)
            }
            
            Text("The time that leads to mastery is dependent on the intensity of our focus")
                .font(.title3)
                .multilineTextAlignment(.center)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .padding()
            
            Button{
                withAnimation{
                    playSound(sound: "success", type: "m4a")
                    onBoarding = true
                }
            }label: {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("Restart")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                    isAnimating = true
                })
            })
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
