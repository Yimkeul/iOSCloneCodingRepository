//
//  RecommandMenuApp.swift
//  RecommandMenu
//
//  Created by yimkeul on 2023/02/24.
//

import SwiftUI
import Firebase

@main
struct RecommandMenuApp: App {
    @StateObject var dataManager = DataManager()
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView().environmentObject(dataManager)
            }
        }
    }
}
