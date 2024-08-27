//
//  SignInView.swift
//  KakaoLoginTutorial
//
//  Created by yimkeul on 2023/09/02.
//

import SwiftUI

struct SignInView: View {
    @State var emailText: String = ""
    @State var passwordText: String = ""
    @State var signInProcessing: Bool = false
    @EnvironmentObject var viewModel: ViewModel                 
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                Text("이메일로 로그인하세요")
                    .font(.largeTitle)
                    .lineSpacing(10)
                
                    VStack {
                        TextField("이메일을 입력하세요", text: $emailText)
                            .padding()
                            .background(.thinMaterial)
                            .cornerRadius(10)
                            .textInputAutocapitalization(.never)
                        SecureField("비밀번호를 입력하세요", text: $passwordText)
                            .padding()
                            .background(.thinMaterial)
                            .cornerRadius(10)
                            .padding(.bottom, 30)
                    }
                    
                    // 로그인 접속중에 signInProcessing = false 이거나 유저 정보가 비어있다면
                    if signInProcessing {
                        ProgressView()
                    }
                
                
                Button {
                    signInProcessing = true
                    viewModel.emailAuthSignIn(email: emailText, password: passwordText)
                } label: {
                    Text("이메일 로그인")
                        .frame(width: 150)
                        .frame(height: 15)

                        .padding()
                        .foregroundColor(.white)
                        .background(emailText.isEmpty || passwordText.isEmpty == true ? .gray : .red)
                        .cornerRadius(10)
                }
                .disabled(emailText.isEmpty || passwordText.isEmpty ? true : false)
                
                Button {
                    signInProcessing = true
                    viewModel.kakaoAuthSignIn()
                } label: {
                    Image("kakao_login_medium_narrow")
                        .renderingMode(.original)
                    
                }.padding(.bottom, 40)
                
                // 회원가입 View로 이동
                HStack {
                    Text("아이디가 없으십니까?")
                    
                    
                    NavigationLink {
                        SignUpView()
                    } label: {
                        HStack {
                            Text("지금 만드세요.")
                            Image(systemName: "arrow.up.forward")
                            
                        }
                    }
                }
                
            }
            .padding()
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
