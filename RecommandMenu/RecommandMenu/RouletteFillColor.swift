//
//  TestRoulettee.swift
//  RecommandMenu
//
//  Created by yimkeul on 2023/02/25.
//

import SwiftUI

struct RouletteFillColor: View {
    
    
    var rouletteData = RouletteData()

    var body: some View {
        
     
            Canvas { context, size in
                let total = rouletteData.rouletteColor.count
                context.translateBy(x: size.width * 0.5, y: size.height * 0.5)
                var pieContext = context
                pieContext.rotate(by: .degrees(-90))
                let radius = min(size.width, size.height) * 0.48
                var startAngle = Angle.zero
                for (color) in rouletteData.rouletteColor {
                    let angle = Angle(degrees: 360 * (1 / Double(total)))
                    let endAngle = startAngle + angle
                    let path = Path { p in
                        p.move(to: .zero)
                        p.addArc(center: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                        p.closeSubpath()
                    }
                    pieContext.fill(path, with: .color(color))
                    
                    startAngle = endAngle
                }
            }
            .aspectRatio(1, contentMode: .fit)
        
    }
}




struct RouletteFillColor_Previews: PreviewProvider {
    static var previews: some View {
        RouletteFillColor()
    }
}

