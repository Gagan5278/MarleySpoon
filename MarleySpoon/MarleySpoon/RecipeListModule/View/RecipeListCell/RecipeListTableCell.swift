//
//  RecipeListTableCell.swift
//  MarleySpoon
//
//  Created by Gagan Vishal on 2020/01/24.
//  Copyright © 2020 Gagan Vishal. All rights reserved.
//

import UIKit

class RecipeListTableCell: UITableViewCell {

    //IBOutlets
    @IBOutlet weak var recipeLogoImageView: UIImageView!
    @IBOutlet weak var logoLoaderIndicator: UIActivityIndicatorView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeInfoLabel: UILabel!
    //MARK:- View Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    var recipeModel: RecipeModel! {
        didSet {
            self.bindDataModel()
        }
    }
    
    //MARK:- Bind data
    private func bindDataModel() {
        self.recipeTitleLabel.text = recipeModel.title
        self.recipeInfoLabel.text = getTagName() ?? ( recipeModel.chef?.name != nil ? ("By: " + (recipeModel.chef?.name)!) :  "")
    }
    
     private func getTagName() -> String? {
       return recipeModel.tags?.reduce([String](), { res, item in
            var arr = res
        arr.append(item.name?.capitalized ?? "")
            return arr
        }).joined(separator: " & ")
    }
    
    //MARK:- Set image
    func setRecipe(logo: UIImage?) {
        //1. Set image if available
        if let _ = logo {
            self.recipeLogoImageView.image = logo
        }
        //2. Stop Activity Indicator
        self.logoLoaderIndicator.stopAnimating()
    }
}
