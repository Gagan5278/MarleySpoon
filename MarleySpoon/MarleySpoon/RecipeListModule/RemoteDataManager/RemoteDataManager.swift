//
//  RemoteDataManager.swift
//  MarleySpoon
//
//  Created by Gagan Vishal on 2020/01/24.
//  Copyright © 2020 Gagan Vishal. All rights reserved.
//

import Foundation

class RemoteDataManager: RecipeRemoteDataManagerInputProtocol {
    var remoteRequestHandler: RecipeRemoteDataManagerOutputProtocol?
    
    //MARK:- Fecth list from server
    func retrieveRecipeList() {
        NetworkCommunicator().fetchRecipeList(value: Items.self) {
          self.handleResult($0)
        }
    }
    
    //MARK:- assing to remoteRequestHandler completion handler
    private func handleResult<T>(_ result: Result<T, APIError>) {
        switch result {
        case .success(let value):
            remoteRequestHandler?.onRecieveRecipe(item: (value as? Items)?.fields ?? [])
        case .failure(let err):
            remoteRequestHandler?.onRecieve(error: err)
        }
    }

}
