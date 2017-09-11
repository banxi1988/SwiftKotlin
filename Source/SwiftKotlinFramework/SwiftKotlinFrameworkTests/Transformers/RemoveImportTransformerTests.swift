//
//  ImportTransformerTests.swift
//  SwiftKotlinFramework
//
//  Created by Haizhen Lee on 27/06/2017.
//  Copyright © 2017 Angel G. Olloqui. All rights reserved.
//

import Foundation

import XCTest

class RemoveImportTransformerTests: XCTestCase {
  var transformer: RemoveImportTransformer!

  override func setUp() {
    super.setUp()
    transformer = RemoveImportTransformer()
  }


  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func testsRemoveImports() {
    let swift =
      "import Foundation\n" +
      "import UIKit\n"
    let kotlin = ""
    let translate = try? transformer.translate(content: swift)
    AssertTranslateEquals(translate, kotlin)
  }

  func testTokens(){
    let swift =
      "init(json:JSON){\n" +
      "}\n"
    
    let transalte =  try? transformer.translate(content: swift)
  }


}
