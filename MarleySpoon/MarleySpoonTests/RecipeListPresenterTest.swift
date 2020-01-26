//
//  RecipeListPresenterTest.swift
//  MarleySpoonTests
//
//  Created by Gagan Vishal on 2020/01/25.
//  Copyright © 2020 Gagan Vishal. All rights reserved.
//

import XCTest
@testable import MarleySpoon

class RecipeListPresenterTest: XCTestCase {
    var recipePresenter: RecipeListPresenter!
    fileprivate var mockView: MockView!
    fileprivate var interactor: MockInteractor!
    fileprivate var router: MockRouter!
    fileprivate var dataManager: MockDataManager!
        
    override func setUp() {
        mockView = MockView()
        presenterSetup()
    }

    override func tearDown() {
        dataManager = nil
        router = nil
        interactor = nil
        mockView = nil
        recipePresenter = nil
    }

    fileprivate func presenterSetup() {
        interactor = MockInteractor()
        router = MockRouter()
        dataManager = MockDataManager()
        interactor.remoteDataManager = dataManager
        dataManager.remoteRequestHandler = interactor
        recipePresenter = RecipeListPresenter(interface: mockView, interactor: interactor, router: router)
    }
    //MARK:- Test Lodaing start
    func testIsLoadingIndicator() {
        interactor.isFail = true
        recipePresenter.fetchRecipeList()
        XCTAssertTrue(mockView.isLoading)
    }
    
    //MARK:- Test Stop Loading
    func testStopLoadingIndicator() {
      interactor.presenter = recipePresenter
      recipePresenter.fetchRecipeList()
      XCTAssertTrue(!mockView.isLoading)
    }
    
    //MARK:- Test Error in fetching list
    func testFetchingError() {
        interactor.presenter = recipePresenter
        interactor.isFail = true
        recipePresenter.fetchRecipeList()
        XCTAssertTrue(mockView.isErrorFound)
    }
    
    func testMockRouterShowAlert(){
        router.showAlert(with: "", message: "", view: mockView!, buttonTitle: "", withCallback: nil)
         XCTAssertTrue(router.isDisplayingAlert)
    }
    
    func testRouterPushed() {
        router.pushToViewController(view: self.mockView, model: (FakeModel.getRecipeListFakeModel()?.fields.first)!)
        XCTAssertTrue(router.isPushed)
    }
    
    func testPresenterShowAlert() {
        interactor.presenter = recipePresenter
        interactor.isFail = true
        recipePresenter.showAlert(with: "", message: "", view: mockView!, with: "", withCallback: nil)
        XCTAssertTrue(router.isDisplayingAlert)
    }
    
    func testPresenterPush()
    {
        interactor.presenter = recipePresenter
        recipePresenter.pushToDetailViewController(view: self.mockView, model: (FakeModel.getRecipeListFakeModel()?.fields.first)!)
        XCTAssertTrue(router.isPushed)
    }
}

fileprivate class MockInteractor: RecipeListInteractorInputProtocol {
    var presenter: RecipeListInteractorOutputProtocol?
    var remoteDataManager: RecipeRemoteDataManagerInputProtocol?
    
    var isFail = false
    var isErrorFoundOnRequest: Bool = false
    
    func fetchRecipeListFromServer() {
         if isFail {
            presenter?.onRecieveServer(error: APIError.invalidData)
         }
         else {
            presenter?.onRecieveRecipe(items: FakeModel.getRecipeListFakeModel()!.fields)
        }
    }
}

extension MockInteractor: RecipeRemoteDataManagerOutputProtocol {
    func onRecieveRecipe(item: [RecipeModel]) {
        isErrorFoundOnRequest = false
    }
    
    func onRecieve(error: APIError) {
        isErrorFoundOnRequest = true
    }
}

fileprivate class MockRouter: RecipeListWireframeProtocol {
    var isDisplayingAlert: Bool = false
    var isPushed: Bool = false

    func showAlert(with title: String, message: String, view: RecipeListViewProtocol, buttonTitle: String, withCallback callBack: ((UIAlertAction) -> Void)?) {
        isDisplayingAlert = true
    }
    
    func pushToViewController(view: RecipeListViewProtocol, model: RecipeModel) {
        isPushed = true
    }
}

fileprivate class MockDataManager: RecipeRemoteDataManagerInputProtocol {
    var remoteRequestHandler: RecipeRemoteDataManagerOutputProtocol?
    
    func retrieveRecipeList() {
        
    }
}

fileprivate class MockView: RecipeListViewProtocol {
    var presenter: RecipeListPresenterProtocol?
    var isLoading: Bool = false
    var isErrorFound: Bool = false
    func didFinishLoading() {
        isLoading = false
    }
    
    func didStartLoading() {
        isLoading = true
    }
    
    func didFetchRecipe(item: [RecipeModel]) {
        isErrorFound = false
    }
    
    func didRecieve(error: APIError) {
        isErrorFound = true
    }
}
