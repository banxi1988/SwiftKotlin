//
//  AddPackageTransformer.swift
//  SwiftKotlinFramework
//
//  Created by Haizhen Lee on 27/06/2017.
//  Copyright © 2017 Angel G. Olloqui. All rights reserved.
//

import Foundation

class AddPackageTransformer:Transformer{
  func transform(formatter: Formatter, options: TransformOptions?) throws {
    formatter.insertToken(.linebreak("\n"), at:0)
    formatter.insertTokens([.keyword("package"),.space(" "), .identifier("com.xypuke.gamemodels")] , at: 0)
  }
}
