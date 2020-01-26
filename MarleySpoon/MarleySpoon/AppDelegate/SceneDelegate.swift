//
//  SceneDelegate.swift
//  MarleySpoon
//
//  Created by Gagan Vishal on 2020/01/25.
//  Copyright © 2020 Gagan Vishal. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let navController = self.window?.rootViewController as? UINavigationController,let recipeController = RecipeListRouter.createRecipeListModule() {
            navController.viewControllers = [recipeController]
        }
        guard let _ = (scene as? UIWindowScene) else { return }
    }

}

