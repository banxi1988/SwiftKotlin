//
//  StructTransformer.swift
//  SwiftKotlinFramework
//
//  Created by Angel Garcia on 09/11/16.
//  Copyright © 2016 Angel G. Olloqui. All rights reserved.
//

import Foundation

class StructTransformer: Transformer {
    func transform(formatter: Formatter, options: TransformOptions? = nil) throws {
        formatter.forEachToken { (i, token) in
            if token == .keyword("struct") {                
                formatter.replaceToken(at: i, with: .keyword("class"))
                formatter.insertTokens([
                    .keyword("data"),
                    .space(" "),
                ], at: i)
              guard let bodyRange = formatter.nextBlockScope(after: i) else{
                return
              }
              formatter.replaceToken(at: bodyRange.lowerBound, with: .startOfScope("("))
              formatter.replaceToken(at: bodyRange.upperBound, with: .startOfScope(")"))
              var nextStartIndex  = bodyRange.lowerBound + 1
              while true{
                if let varIndex = formatter.indexVariableToken(after: nextStartIndex){
                  if let brIndex = formatter.index(of: .linebreak, after: varIndex){
                    formatter.insertToken(.delimiter(","), at: brIndex)
                    nextStartIndex = brIndex + 1
                  }else{
                    break
                  }
                }else{
                  break
                }
              }
            }
        }
    }
}

extension Formatter{
  func indexVariableToken(after index:Int) -> Int?{
    return self.index(after: index){ (token) -> Bool in
       return token.isKeyword && (token.string == "var" || token.string == "let")
    }

  }
}
