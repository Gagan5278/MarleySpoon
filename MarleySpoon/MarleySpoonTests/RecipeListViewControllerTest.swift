//
//  RecipeListViewControllerTest.swift
//  MarleySpoonTests
//
//  Created by Gagan Vishal on 2020/01/25.
//  Copyright © 2020 Gagan Vishal. All rights reserved.
//

import XCTest
@testable import MarleySpoon
class RecipeListViewControllerTest: XCTestCase {
    var recipeListViewController: RecipeListViewController!
    override func setUp() {
        if let controller = RecipeListRouter.createRecipeListModule() as? RecipeListViewController {
            self.recipeListViewController = controller
            self.recipeListViewController.loadView()
            self.recipeListViewController.viewDidLoad()
        }
    }
    
    override func tearDown() {
        self.recipeListViewController = nil
    }
    
    //MARK:- Test view available or not
    func testMainView() {
        XCTAssertNotNil(self.recipeListViewController.view, "Could not find RecipeListViewController")
    }
    
    //MARK:- Test TableView
    func testTableView() {
        XCTAssertNotNil(self.recipeListViewController.recipeListTableView)
    }
    
    //MARK:- Test View has a tableView
    func testViewHasATableViewAsSubView()
    {
        XCTAssertTrue((self.recipeListViewController.view.subviews.contains(self.recipeListViewController.recipeListTableView)), "View does not contain UITableView as subview")
    }
    
    //MARK:- Test TableView Delegate
    func testTableViewDelegate() {
        XCTAssertNotNil(self.recipeListViewController.recipeListTableView.delegate, "TableView Delegate is nil")
    }
    
    //MARK:- Test View Confirm TableView Delegate
    func testViewConfirmTableViewDelegate()
    {
        XCTAssertTrue(self.recipeListViewController.conforms(to: UITableViewDelegate.self), "View does not confirm tableView Delegate")
    }
    
    //MARK:- Test TableView DataSource
    func testViewHasTableViewDataSource()
    {
        XCTAssertNotNil(self.recipeListViewController.recipeListTableView.dataSource, "Table view data source is nil")
    }
    
    //MARK:- Test View Confrim DataSource Protocol
    func testViewConfirmTableViewDataSource() {
        
        XCTAssertTrue(self.recipeListViewController.conforms(to: UITableViewDataSource.self), "View does not confirm tableView DataSource")
    }
    
    //MARK:- Test Number of rows in UITableView
    func testNumberOfRowsInTableView()
    {
        fakeModelSetup()
        let tableView = recipeListViewController.recipeListTableView
        XCTAssertEqual(self.recipeListViewController.arrayOfRecipeItems.count, tableView!.dataSource?.tableView(tableView!, numberOfRowsInSection: 0))
    }
    
    //MARK:- Test Push to imagedetail
    func testPushToImageDetail() {
        fakeModelSetup()
        self.recipeListViewController.tableView(self.recipeListViewController.recipeListTableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
    }
    
    //MARK:- Test cellForRowAtIndexPath
    func testForCellInUITableVieew()
    {
        fakeModelSetup()
        let recipeCell = self.recipeListViewController.recipeListTableView.dequeueReusableCell(withIdentifier: self.recipeListViewController.cellIdentifier)
        XCTAssertNotNil(recipeCell, "UITableViewCell not found in UITableView")
    }
    
    //MARK:- test row height
    func testRowHeight()
    {
        XCTAssertTrue(self.recipeListViewController.recipeListTableView.rowHeight  != 0, "TableView row height is invalid")
    }
    
    fileprivate func fakeModelSetup()
    {
        if let model = FakeModel.getRecipeListFakeModel() {
            self.recipeListViewController.arrayOfRecipeItems = model.fields
        }
    }
}
