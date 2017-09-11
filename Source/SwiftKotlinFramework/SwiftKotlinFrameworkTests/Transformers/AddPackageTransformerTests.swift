//
//  AddPackageTransformerTests.swift
//  SwiftKotlinFramework
//
//  Created by Haizhen Lee on 27/06/2017.
//  Copyright © 2017 Angel G. Olloqui. All rights reserved.
//

import XCTest

class AddPackageTransformerTests: XCTestCase {
  var transformer: AddPackageTransformer!

  override func setUp() {
    super.setUp()
    transformer = AddPackageTransformer()
  }


  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func testsRemoveImports() {
    let swift = ""
    let kotlin = "package com.xypuke.gamemodels\n"
    let translate = try? transformer.translate(content: swift)
    AssertTranslateEquals(translate, kotlin)
  }

}
