//
//  RotationTest.swift
//  RecommandMenu
//
//  Created by yimkeul on 2023/02/24.
//

import SwiftUI

struct Roulette: View {
    
    @EnvironmentObject var dataManager : DataManager
    
    @State var doRoulette : Bool = false
    // 룰렛이 돌아가고 있는 지 판별 (true : 동작중 , false : 멈춤)
    @State var isShownRoulette: Bool  = true
    // 룰렛이 보여지고 있는지 판별 (true : show, false : hidden)
    @State var degreeRoulette : Double = 0
    // 룰렛이 원형으로 돌기 위한 각도 값
    @State var durationTime : Double = 0
    // 롤렛이 돌는 시간 값
    
    
    var rouletteData = RouletteData()
    

    
    var body: some View {
        VStack{
   
            if isShownRoulette{
                VStack{
                    let rouletteDataLength = Double(rouletteData.rouletteText.count)
                    let rouletteDegreeFirstValue = round(Double(360/rouletteDataLength)*10)/10
                    let rouletteDegreeSecondValue = round(Double(360/(rouletteDataLength*2))*10)/10
                    
                    ZStack{
                        Circle()
                            .foregroundColor(Color("BorderRoulette"))
                        
                        RouletteFillColor()
                        ForEach(0..<Int(rouletteDataLength), id:\.self) { data  in
                            Image(rouletteData.rouletteText[data])
                                .resizable()
                                .frame(width: 30 ,height: 30)
                                .offset(x: 0, y: -120)
                                .rotationEffect(.degrees(Double(data)*rouletteDegreeFirstValue+rouletteDegreeSecondValue))
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: 300, height: 310)
                    .rotationEffect(.degrees(degreeRoulette))
                    .animation(.easeOut(duration: durationTime), value: doRoulette )
                    
                    Text("🔻")
                        .font(.title)
                        .offset(y:-330)
                    Spacer()
                    
                    if doRoulette == false{
                        Button {
                            doRoulette = true
                            degreeRoulette = 200*10
                            durationTime = 5
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.8) {
                                isShownRoulette = false
                            }
                        } label: {
                            Text("🕹️ 룰렛 돌리기")
                                .font(.largeTitle)
                        }
                    }
                }
            }
            else{
//                let randomInt:Int = Int.random(in: 0...13)
//
//                Image(rouletteData.rouletteText[randomInt])
//                    .resizable()
//                    .frame(width: 300, height: 300, alignment: .center)
//                Text(rouletteData.rouletteText[randomInt])
//                    .font(.largeTitle)
          
//                let randomInt : Int = Int.random(in 0... FirebaseDataLength)

//                List(dataManager.menus, id : \.id) {
//                    menu in
//                    Text(menu.name)
//                }
//
                Spacer()
                let randomInt : Int = Int.random(in: 0...dataManager.menus.count-1)
                
                Text(dataManager.menus[randomInt].name + " 땡겨요").font(.largeTitle)
        
                Spacer()
                Button {
                    isShownRoulette = true
                    doRoulette = false
                    degreeRoulette = 0
                    durationTime = 0
                } label: {
                    Text("⬅️ 다시 돌리기")
                        .font(.largeTitle)
                }
            }
        }
    }
}

struct Roulette_Previews: PreviewProvider {
    static var previews: some View {
        Roulette().environmentObject(DataManager())
    }
}
