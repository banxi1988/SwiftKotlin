//
//  RemoveCutomTypeTransformer.swift
//  SwiftKotlinFramework
//
//  Created by Haizhen Lee on 27/06/2017.
//  Copyright © 2017 Angel G. Olloqui. All rights reserved.
//

import XCTest

class RemoveCutomTypeTransformer: XCTestCase {

  var transformer: CustomTypeTransformer!

  override func setUp() {
    super.setUp()
    transformer = CustomTypeTransformer()
  }


  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func testsRemoveBXModel() {
    let swift = "struct Hand:BXModel{\n"
    let kotlin = "struct Hand{\n"
    let translate = try? transformer.translate(content: swift)
    AssertTranslateEquals(translate, kotlin)
  }
}
