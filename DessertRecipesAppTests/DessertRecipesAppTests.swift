//
//  DessertRecipesAppTests.swift
//  DessertRecipesAppTests
//
//  Created by Jaya Siva Bhaskar Karlapalem on 9/21/24.
//

import XCTest
@testable import DessertRecipesApp

final class DessertRecipesAppTests: XCTestCase {

    var viewModel: DessertViewModel!
    private var mockService =  MockService()
    
    override func setUpWithError() throws {
        viewModel = DessertViewModel(service: mockService)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testMealsModelData() async throws {
        await viewModel.fetchMeals()
        
        XCTAssertFalse(viewModel.meals.isEmpty, "meals should not be empty")
        XCTAssertTrue(viewModel.meals.count == 65)
        XCTAssertEqual(viewModel.meals.first?.strMeal, "Apam balik")
        XCTAssertFalse(viewModel.isError)
    }
    
    func testMealDetailsModelData() async throws {
        await viewModel.fetchMealDetail(by: "53049")
        
        XCTAssertFalse(viewModel.meals.isEmpty, "meals should not be empty")
        XCTAssertTrue(viewModel.meals.count == 1)
        XCTAssertEqual(viewModel.meals.first?.strMeal, "Apam balik")
        XCTAssertFalse(viewModel.isError)
    }
}

class MockService: APIManagerService, Mockable {
    func request<T>(type: EndPointType) async throws -> T where T : Decodable {
        return self.loadJson(fileName: type.mockFileName, decodeType: T.self)
    }
}
