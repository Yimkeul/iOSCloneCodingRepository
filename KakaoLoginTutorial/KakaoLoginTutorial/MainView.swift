//
//  MainView.swift
//  KakaoLoginTutorial
//
//  Created by yimkeul on 2023/09/02.
//

import SwiftUI


struct MainView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        Text("로그인 성공")
        Button {
            viewModel.emailAuthSignOut()
        } label: {
            Text("로그아웃")
        }

    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(ViewModel())
    }
}
