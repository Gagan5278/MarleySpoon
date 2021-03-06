//
//  RecipeDetailRouter.swift
//  MarleySpoon
//
//  Created Gagan Vishal on 2020/01/24.
//  Copyright © 2020 Gagan Vishal. All rights reserved.
//
//  Template generated by Gagan Vishal @gagan5278
//

import UIKit

class RecipeDetailRouter: RecipeDetailWireframeProtocol {
    
    weak var viewController: UIViewController?
    
    static func createDetailModule(with model: RecipeModel) -> RecipeDetailViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = RecipeDetailViewController()
        let interactor = RecipeDetailInteractor()
        let router = RecipeDetailRouter()
        let presenter = RecipeDetailPresenter(interface: view, interactor: interactor, router: router, model: model)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    //MARK:- Alert message
    func showAlert(with title: String, message: String, view: RecipeDetailViewProtocol, buttonTitle: String, withCallback callBack: ((UIAlertAction) -> Void)?) {
        if let viewController = view as? UIViewController {
            CustomAlertController.showUserAlert(with: title, message: message, buttonTitle: buttonTitle, onViewController: viewController, withCallback: callBack)
        }
    }
}
