//
//  ContentView.swift
//  Restart
//
//  Created by Meet Patel on 2023-11-06.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("onboarding") var onBoarding: Bool = true
    var body: some View {
        ZStack {
            if(onBoarding){
                OnBoardingScreen()
                    
            }else{
                HomeScreen()
                  
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
