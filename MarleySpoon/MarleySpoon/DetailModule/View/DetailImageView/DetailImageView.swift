//
//  DetailImageView.swift
//  MarleySpoon
//
//  Created by Gagan Vishal on 2020/01/24.
//  Copyright © 2020 Gagan Vishal. All rights reserved.
//

import UIKit

class DetailImageView: UIImageView {
    ///Taged used to identify added imageview
    fileprivate let imageTag = 1234
    ///full screen imageview
    var fullscreenImageView: UIImageView!
    ///label to display user message when full screen image available
    var closeLabel: UILabel!
    //MARK:- View life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    //MARK:- Setup image view
    fileprivate func setup() {
        //add Tap gesture on imageview
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(showFullscreen))
        self.addGestureRecognizer(touchGesture)
    }
    
    //MARK:- Create a full screen photo
    fileprivate func createFullscreenPhoto() -> UIImageView {
        //1. Create a new imageview
        let tmpImageView = UIImageView(frame: self.frame)
        tmpImageView.image = self.image
        tmpImageView.contentMode = .scaleAspectFit
        tmpImageView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tmpImageView.tag = imageTag
        tmpImageView.alpha = 0.0
        tmpImageView.isUserInteractionEnabled = true
        //2. add Tap gesture for hide action
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideFullscreen))
        tmpImageView.addGestureRecognizer(tap)
        //3.return imageview
        return tmpImageView
    }
    
    //MARK:- Add label on bottom of screen to guide hide action for user
    fileprivate func createLabel() -> UILabel {
        
        let label = UILabel(frame: CGRect.zero)
        label.text = "Touch anywhere to hide"
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor(white: 0.85, alpha: 1)
        label.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        label.alpha = 0.0
        return label
    }
    
    //MARK:- Tap action to display image in full screen
    @objc func showFullscreen() {
        if let superView = self.superview, superView.viewWithTag(imageTag) == nil {
            //1. Create new imageview
            self.fullscreenImageView = createFullscreenPhoto()
            //2. Create a label
            self.closeLabel = createLabel()
            //3. add label on ImageView
            self.fullscreenImageView.addSubview(closeLabel)
            //4.add imageview on windoe
            superView.addSubview(self.fullscreenImageView)
            UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
                self.fullscreenImageView.frame = superView.frame
                self.fullscreenImageView.alpha = 1
                self.fullscreenImageView.layoutSubviews()
                self.closeLabel.alpha = 1
            }, completion: { _ in
                self.setupLabelAnchor()
            })
        }
    }
    
    //MARK:- label achhor setup
    fileprivate func setupLabelAnchor() {
        self.closeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.closeLabel.trailingAnchor.constraint(equalTo: self.fullscreenImageView.trailingAnchor),
            self.closeLabel.leadingAnchor.constraint(equalTo: self.fullscreenImageView.leadingAnchor),
            self.closeLabel.bottomAnchor.constraint(equalTo: self.fullscreenImageView.bottomAnchor),
            self.closeLabel.heightAnchor.constraint(equalTo: self.fullscreenImageView.heightAnchor, multiplier: 0.10)
        ])
    }
    
    //MARK:- Hide full screen image
    @objc func hideFullscreen() {
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
            self.fullscreenImageView?.frame = self.frame
            self.closeLabel?.alpha = 0.0
            self.fullscreenImageView?.alpha = 0.0
            
        }, completion: { finished in
            self.fullscreenImageView?.removeFromSuperview()
            self.fullscreenImageView = nil
            self.closeLabel = nil
        })
    }
}
