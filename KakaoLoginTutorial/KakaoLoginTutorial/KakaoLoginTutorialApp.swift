//
//  KakaoLoginTutorialApp.swift
//  KakaoLoginTutorial
//
//  Created by yimkeul on 2023/09/01.
//

import SwiftUI
import FirebaseCore
import KakaoSDKCommon
import KakaoSDKAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()

        return true
    }
}

@main
struct KakaoLoginTutorialApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var viewModel: ViewModel = ViewModel()
    init() {
        KakaoSDK.initSDK(appKey: "1d34155f932de8bb03059be0b8c06353")
    }
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environmentObject(viewModel)
                    .onOpenURL { url in
                    if AuthApi.isKakaoTalkLoginUrl(url) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                }
            }
        }
    }
}
