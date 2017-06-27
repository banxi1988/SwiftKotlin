//
//  ImportTransformer.swift
//  SwiftKotlinFramework
//
//  Created by Haizhen Lee on 27/06/2017.
//  Copyright © 2017 Angel G. Olloqui. All rights reserved.
//

import Foundation

class ImportTransformer:Transformer{
  func transform(formatter: Formatter, options: TransformOptions?) throws {
    formatter.forEachToken{ (index, token) in
      if token == .keyword("import"){
        formatter.removeToken(at: index) // import
        formatter.removeToken(at: index) // space
        formatter.removeToken(at: index) // identifier
        formatter.removeToken(at: index) // linebreak
      }
    }
  }
  
}
