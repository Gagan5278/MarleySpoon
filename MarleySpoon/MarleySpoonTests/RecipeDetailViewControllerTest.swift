//
//  RecipeDetailViewControllerTest.swift
//  MarleySpoonTests
//
//  Created by Gagan Vishal on 2020/01/25.
//  Copyright © 2020 Gagan Vishal. All rights reserved.
//

import XCTest
@testable import MarleySpoon
class RecipeDetailViewControllerTest: XCTestCase {
    var recipeDetailViewController:RecipeDetailViewController!
    
    override func setUp() {
         self.recipeDetailViewController  = RecipeDetailRouter.createDetailModule(with: ((FakeModel.getRecipeListFakeModel()?.fields.first)!))
            recipeDetailViewController.loadView()
            recipeDetailViewController.viewDidLoad()
    
    }

    override func tearDown() {
        recipeDetailViewController = nil
    }

    func testViewExist()
    {
        XCTAssertNotNil(recipeDetailViewController.view)
    }
    
    func testViewHasAImageView()
    {
        XCTAssertTrue(recipeDetailViewController.view.subviews.contains(recipeDetailViewController.detailImageView))
    }
    
    func testViewHasATextView() {
        XCTAssertTrue(recipeDetailViewController.view.subviews.contains(recipeDetailViewController.detailTextView))
    }
}
