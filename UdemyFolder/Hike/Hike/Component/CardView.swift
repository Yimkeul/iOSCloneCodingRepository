//
//  CardView.swift
//  Hike
//
//  Created by yimkeul on 2023/07/23.
//

import SwiftUI

struct CardView: View {
    
    @State private var imageNumber: Int = 1
    @State private var randomNumber: Int = 1
    @State private var isShowingSheet: Bool = false
    
    func randomImage() {
        repeat {
            randomNumber = Int.random(in: 1...5)
        } while randomNumber == imageNumber
        
        imageNumber = randomNumber
    }
    
    
    var body: some View {
        ZStack{
            CustomBackgroundView()
            VStack{
                // MARK: HEADER
                VStack(alignment: .leading){
                    HStack{
                        Text("Hiking")
                            .fontWeight(.black)
                            .font(.system(size: 52))
                            .foregroundStyle(LinearGradient(colors: [.customGrayLight , .customGrayMedium], startPoint: .top, endPoint: .bottom))
                        Spacer()
                        Button {
                            print("Button pressed")
                            isShowingSheet.toggle()
                        } label: {
                            CustomButtonView()
                        }
                        .sheet(isPresented: $isShowingSheet) {
                            SettingView()
                                .presentationDragIndicator(.visible)
                                .presentationDetents([.medium,.large])
                        }
                        
                    }
                    Text("Fun and enjoyable outdoor activity for friends and familes.")
                        .multilineTextAlignment(.leading)
                        .italic()
                        .foregroundColor(.customGrayMedium)
                }
                .padding(.horizontal, 30)
                // MARK: CONTENT
                ZStack{
                    CustomCircleView()
                    Image("image-\(imageNumber)")
                        .resizable()
                        .scaledToFit()
                        .animation(.easeOut(duration: 5), value: imageNumber)
                }
                // MARK: FOOTER
                Button {
                    print("Button Pressed")
                    randomImage()
                } label: {
                    Text("Explore More")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundStyle(LinearGradient(colors: [.customGreenLight, .customGreenMedium], startPoint: .top, endPoint: .bottom))
                        .shadow(color:.black.opacity(0.25) , radius: 0.25,x:1,y:2)
                }.buttonStyle(GradientButton())
                
                
            }
        }
        .frame(width: 320, height: 570)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
