//
//  RecipeDetailPresenterTest.swift
//  MarleySpoonTests
//
//  Created by Gagan Vishal on 2020/01/25.
//  Copyright © 2020 Gagan Vishal. All rights reserved.
//

import XCTest
@testable import MarleySpoon
class RecipeDetailPresenterTest: XCTestCase {
    var presenter: RecipeDetailPresenter!
    fileprivate var router: MockDetailRouter!
    fileprivate var interactor: MockDetailInteractor!
    fileprivate var view: MockView!
    
    override func setUp() {
        setupPresenter()
    }
    
    override func tearDown() {
        router = nil
        interactor = nil
        view = nil
        presenter = nil
    }
    
    fileprivate func setupPresenter() {
        router = MockDetailRouter()
        interactor = MockDetailInteractor()
        view = MockView()
        self.presenter = RecipeDetailPresenter(interface: view, interactor: interactor, router: router, model: (FakeModel.getRecipeListFakeModel()?.fields.first)!)
    }
    
    //MARK:- test show alert
    func testPresenterShowAlert() {
        interactor.presenter = presenter
        presenter.showAlert(with: "", message: "", view: view!, buttonTitle: "", withCallback: nil)
        XCTAssertTrue(router.isAlertVisible)
    }
    
    //MARK:-
    func testIsLoadingIndicator() {
        presenter.viewLoaded()
        XCTAssertTrue(view.isDetailTextLoaded)
    }
}

fileprivate class MockDetailInteractor: RecipeDetailInteractorProtocol {
    var presenter: RecipeDetailPresenterProtocol?
}

fileprivate class MockDetailRouter: RecipeDetailWireframeProtocol {
    var isAlertVisible: Bool = false
    func showAlert(with title: String, message: String, view: RecipeDetailViewProtocol, buttonTitle: String, withCallback callBack: ((UIAlertAction) -> Void)?) {
        isAlertVisible = true
    }
}

fileprivate class MockView: RecipeDetailViewProtocol {
    var presenter: RecipeDetailPresenterProtocol?
    var isDetailTextLoaded: Bool = false
    var isImageLoaded: Bool = false
    func didLoadDetail(from text: NSAttributedString) {
        isDetailTextLoaded = true
    }
    
    func didLoad(image: UIImage?) {
        isImageLoaded = true
    }
}
