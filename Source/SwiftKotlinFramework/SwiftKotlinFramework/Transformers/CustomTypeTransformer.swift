//
//  CustomTypeTransformer.swift
//  SwiftKotlinFramework
//
//  Created by Haizhen Lee on 27/06/2017.
//  Copyright © 2017 Angel G. Olloqui. All rights reserved.
//

import Foundation

let customTypeMap:[String:String] = [
  "BXModel":"",
  "JSON":"",
]

class CustomTypeTransformer:Transformer{
  func transform(formatter: Formatter, options: TransformOptions?) throws {
    // remove ":BXModel"
    formatter.forEach(.identifier("BXModel")){ (index,token) in
      formatter.removeToken(at: index)
      formatter.removeToken(at: index - 1)
    }
  }
}
