//
//  FrutusApp.swift
//  Frutus
//
//  Created by yimkeul on 2023/08/01.
//

import SwiftUI

@main
struct FrutusApp: App {
    @AppStorage("isOnboarding") var isOnboarding:Bool = true
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                OnboardingView()
            } else {
                ContentView()
            }
        }
    }
}
