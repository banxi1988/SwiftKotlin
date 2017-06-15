/*
   Copyright 2017 Ryuichi Saito, LLC and the Yanagiba project contributors

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

@testable import AST
@testable import Parser

class ParserImportDeclarationTests: XCTestCase {
  func testImportModule() {
    parseDeclarationAndTest("import foo", "import foo", testClosure: { decl in
      guard let importDecl = decl as? ImportDeclaration else {
        XCTFail("Failed in getting an import declaration.")
        return
      }

      XCTAssertTrue(importDecl.attributes.isEmpty)
      XCTAssertNil(importDecl.kind)
      XCTAssertEqual(importDecl.path.count, 1)
      XCTAssertEqual(importDecl.path[0], "foo")
    })
  }

  func testImportOperator() {
    parseDeclarationAndTest("import >>", "import >>", testClosure: { decl in
      guard let importDecl = decl as? ImportDeclaration else {
        XCTFail("Failed in getting an import declaration.")
        return
      }

      XCTAssertTrue(importDecl.attributes.isEmpty)
      XCTAssertNil(importDecl.kind)
      XCTAssertEqual(importDecl.path.count, 1)
      XCTAssertEqual(importDecl.path[0], ">>")
    })
  }

  func testNestedPath() {
    parseDeclarationAndTest("import A.B.C.<<=", "import A.B.C.<<=", testClosure: { decl in
      guard let importDecl = decl as? ImportDeclaration else {
        XCTFail("Failed in getting an import declaration.")
        return
      }

      XCTAssertTrue(importDecl.attributes.isEmpty)
      XCTAssertNil(importDecl.kind)
      XCTAssertEqual(importDecl.path.count, 4)
      XCTAssertEqual(importDecl.path[0], "A")
      XCTAssertEqual(importDecl.path[1], "B")
      XCTAssertEqual(importDecl.path[2], "C")
      XCTAssertEqual(importDecl.path[3], "<<=")
    })
  }

  func testAttribute() {
    parseDeclarationAndTest("@exported import foo", "@exported import foo", testClosure: { decl in
      guard let importDecl = decl as? ImportDeclaration else {
        XCTFail("Failed in getting an import declaration.")
        return
      }

      XCTAssertEqual(importDecl.attributes.count, 1)
      XCTAssertEqual(importDecl.attributes[0].name, "exported")
      XCTAssertNil(importDecl.kind)
      XCTAssertEqual(importDecl.path.count, 1)
      XCTAssertEqual(importDecl.path[0], "foo")
    })
  }

  func testImportKinds() {
    for kind in ImportDeclaration.Kind.cases {
      parseDeclarationAndTest("import \(kind.rawValue) foo", "import \(kind.rawValue) foo", testClosure: { decl in
        guard let importDecl = decl as? ImportDeclaration else {
          XCTFail("Failed in getting an import declaration.")
          return
        }

        XCTAssertTrue(importDecl.attributes.isEmpty)
        XCTAssertEqual(importDecl.kind, kind)
        XCTAssertEqual(importDecl.path.count, 1)
        XCTAssertEqual(importDecl.path[0], "foo")
      })
    }
  }

  func testSourceRange() {
    parseDeclarationAndTest(
      "import foo",
      "import foo",
      testClosure: { decl in
        XCTAssertEqual(decl.sourceRange, getRange(1, 1, 1, 11))
      }
    )
    parseDeclarationAndTest(
      "import A.B.C.<<=",
      "import A.B.C.<<=",
      testClosure: { decl in
        XCTAssertEqual(decl.sourceRange, getRange(1, 1, 1, 17))
      }
    )
  }

  static var allTests = [
    ("testImportModule", testImportModule),
    ("testImportOperator", testImportOperator),
    ("testNestedPath", testNestedPath),
    ("testAttribute", testAttribute),
    ("testImportKinds", testImportKinds),
    ("testSourceRange", testSourceRange),
  ]
}
