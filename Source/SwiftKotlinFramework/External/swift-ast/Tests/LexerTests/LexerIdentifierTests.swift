/*
   Copyright 2015-2016 Ryuichi Saito, LLC and the Yanagiba project contributors

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

import XCTest

@testable import Lexer
@testable import Source

class LexerIdentifierTests: XCTestCase {
  let identifiers = ["foo", "_bar", "_1", "R2D2", "😃", "abc_"]

  func testIdentifiers() {
    identifiers.forEach { i in
      lexAndTest(i) { t in
        XCTAssertEqual(t, .identifier(i))
      }
    }
  }

  func testBacktickIdentifiers() {
    let backtickIdentifiers = identifiers + ["public", "true", "class"]
    backtickIdentifiers.forEach { i in
      let backtickIdentifier = "`\(i)`"
      lexAndTest(backtickIdentifier) { t in
        XCTAssertEqual(t, .identifier(i))
      }
    }
  }

  func testBacktickIdentifierMissingClosingBacktick() {
    lexAndTest("`class") { t in
      XCTAssertEqual(t, .invalid(.closingBacktickExpected))
    }
  }

  func testImplicitParameterName() {
    let decimalDigits = [0, 1, 12, 123]
    decimalDigits.forEach { d in
      let implicitParameterName = "$\(d)"
      lexAndTest(implicitParameterName) { t in
        XCTAssertEqual(t, .implicitParameterName(d))
      }
    }
  }

  func testStructName() {
    lexAndTest("foo") { t in
      XCTAssertEqual(t.structName, "foo")
    }
    lexAndTest("Type") { t in
      XCTAssertEqual(t.structName, "Type")
    }
    lexAndTest("Protocol") { t in
      XCTAssertEqual(t.structName, "Protocol")
    }
    lexAndTest("class") { t in
      XCTAssertNil(t.structName)
    }
  }

  static var allTests = [
    ("testIdentifiers", testIdentifiers),
    ("testBacktickIdentifiers", testBacktickIdentifiers),
    ("testBacktickIdentifierMissingClosingBacktick", testBacktickIdentifierMissingClosingBacktick),
    ("testImplicitParameterName", testImplicitParameterName),
    ("testStructName", testStructName),
  ]
}
