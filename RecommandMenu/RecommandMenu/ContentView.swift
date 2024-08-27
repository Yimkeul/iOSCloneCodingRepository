//
//  ContentView.swift
//  RecommandMenu
//
//  Created by yimkeul on 2023/02/24.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var dataManager : DataManager
    var body: some View {
        VStack {
            Text("지금은").font(.largeTitle)
            Roulette()
            .frame(maxWidth: .infinity , maxHeight: 500)
                
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(DataManager())
    }
}
