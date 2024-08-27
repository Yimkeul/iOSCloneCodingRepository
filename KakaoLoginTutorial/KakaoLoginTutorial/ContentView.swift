//
//  ContentView.swift
//  KakaoLoginTutorial
//
//  Created by yimkeul on 2023/09/01.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            if viewModel.state == .signedIn   {
                MainView()
            } else {
                SignInView()
            }
        }.task{
            viewModel.getAuthInfo()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ViewModel())
    }
}
