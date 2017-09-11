//
//  EnumTransformer.swift
//  SwiftKotlinFramework
//
//  Created by Haizhen Lee on 27/06/2017.
//  Copyright © 2017 Angel G. Olloqui. All rights reserved.
//

import Foundation

class EnumTransformer:Transformer{
  func transform(formatter: Formatter, options: TransformOptions?) throws {
    formatter.forEach(.keyword("enum")){ (i,token) in
      formatter.insertTokens([.space("\t"),.keyword("class") ,.space("\t")], at: i)
    }
  }
}
