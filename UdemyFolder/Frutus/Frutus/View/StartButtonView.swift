//
//  StartButtonView.swift
//  Frutus
//
//  Created by yimkeul on 2023/08/01.
//

import SwiftUI

struct StartButtonView: View {
    
    @AppStorage("isOnboarding") var isOnboarding:Bool?
    var body: some View {
        Button {
            isOnboarding = false
        } label: {
            HStack(spacing : 8){
                Text("start")
                Image(systemName: "arrow.right.circle")
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                Capsule().strokeBorder(.white,lineWidth: 1.25)
                
            )
        }.tint(.white)

    }
}

struct StartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StartButtonView()
    }
}
