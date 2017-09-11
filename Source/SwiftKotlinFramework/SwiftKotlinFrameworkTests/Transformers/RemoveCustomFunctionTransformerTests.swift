//
//  RemoveCustomFunctionTransformerTests.swift
//  SwiftKotlinFramework
//
//  Created by Haizhen Lee on 27/06/2017.
//  Copyright © 2017 Angel G. Olloqui. All rights reserved.
//

import XCTest

class RemoveCustomFunctionTransformerTests: XCTestCase {

  var transformer: RemoveCustomFunctionTransformer!

  override func setUp() {
    super.setUp()
    transformer = RemoveCustomFunctionTransformer()
  }


  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func testsRemoveJSONInit() {
    let swift =
    "init(json:JSON){\n" +
    "self.age = 18" +
    "}\n"
    let kotlin = ""
    let translate = try? transformer.translate(content: swift)
    AssertTranslateEquals(translate, kotlin)
  }

  func testsRemoveToDict() {
    let swift =
    "func toDict() -> [String:Any]{\n" +
    "var dict : [String:Any] = [:]\n" +
    "dict[\"age\"] = 18\n" +
    " return dict \n" +
    "}\n"
    let kotlin = ""
    let translate = try? transformer.translate(content: swift)
    AssertTranslateEquals(translate, kotlin)
  }
}
