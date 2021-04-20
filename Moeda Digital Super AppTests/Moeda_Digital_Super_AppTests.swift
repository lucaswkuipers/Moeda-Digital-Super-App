//
//  Moeda_Digital_Super_AppTests.swift
//  Moeda Digital Super AppTests
//
//  Created by Lucas Werner Kuipers on 14/04/2021.
//

import XCTest
@testable import Moeda_Digital_Super_App


class Moeda_Digital_Super_AppTests: XCTestCase {
    
  var vc: TabBarVC!
  var vcF: FavoriteViewController!
  var vcC: CoinListVC!

	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTabBar() throws {
            vc = TabBarVC()
            vc.viewDidLoad()
        }
        

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
