//
//  RemoveFunctionTransformer.swift
//  SwiftKotlinFramework
//
//  Created by Haizhen Lee on 27/06/2017.
//  Copyright © 2017 Angel G. Olloqui. All rights reserved.
//

import Foundation

class RemoveCustomFunctionTransformer:Transformer{
  func transform(formatter: Formatter, options: TransformOptions?) throws {
      transformJSONInit(formatter)
      transformToDictFunction(formatter)
  }

  func transformJSONInit(_ formatter: Formatter) {
    formatter.forEach(.keyword("init")) { (i, token) in
      if formatter.token(at:i + 2) == .identifier("json"){
        if let funcRange = formatter.nextBlockScope(after:i) {
          formatter.removeTokens(inRange:i...(funcRange.upperBound))
          formatter.removeSpacingOrLinebreakTokens(at:i)
        }
      }
    }
  }

  func transformToDictFunction(_ formatter: Formatter) {
    formatter.forEach(.keyword("func")) { (i, token) in
      if formatter.token(at: i + 2) == .identifier("toDict"){
        if let funcRange = formatter.nextBlockScope(after:i) {
          formatter.removeTokens(inRange:i...(funcRange.upperBound))
          formatter.removeSpacingOrLinebreakTokens(at:i)
        }
      }
    }
  }

}
