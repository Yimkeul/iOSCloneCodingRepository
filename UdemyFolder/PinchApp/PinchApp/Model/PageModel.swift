//
//  PageModel.swift
//  PinchApp
//
//  Created by yimkeul on 2023/07/31.
//

import Foundation 

struct Page: Identifiable {
  let id: Int
  let imageName: String
}

extension Page {
  var thumbnailName: String {
    return "thumb-" + imageName
  }
}
