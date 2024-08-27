//
//  RouletteData.swift
//  RecommandMenu
//
//  Created by yimkeul on 2023/02/26.
//

import Foundation
import SwiftUI

class RouletteData {

    var rouletteText : [String] = []
    var rouletteColor : [Color] = []
    init(){
        setup()
    }
    
     func setup(){
         rouletteColor  = [Color("chick"),Color("pink"),Color("chick"),Color("pink"),Color("chick"),Color("pink"),Color("chick"),Color("pink"),Color("chick"),Color("pink"),Color("chick"),Color("pink"),Color("chick"),Color("pink"),]

         rouletteText = ["bento","bossam","chicken","cupcake","gogi","hamburger","jajangmyeon","pizza","rice","spaghetti","sushi","tang","tteokbokki","noodles"]
  
         
         
    }
    
    
}

