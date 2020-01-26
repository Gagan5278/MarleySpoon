//
//  ImageOperation.swift
//  BitPanda
//
//  Created by Gagan Vishal on 2020/01/25.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
import UIKit

class ImageOperation: Operation {
    //image download completion handler
    var imageDownloadCompletionHandler: ImageDownloadCompletionHandler?
    //current index path for cell item
    var indexPath: IndexPath
    //image URL
    var downloadImageURL: URL
    
    init(indexPath: IndexPath, url: URL) {
        self.indexPath = indexPath
        self.downloadImageURL = url
    }
    
    private var _executing = false {
        willSet {
            willChangeValue(forKey: "isExecuting")
        }
        didSet {
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    override var isExecuting: Bool {
        return _executing
    }
    
    private var _finished = false {
        willSet {
            willChangeValue(forKey: "isFinished")
        }
        
        didSet {
            didChangeValue(forKey: "isFinished")
        }
    }
    
    override var isFinished: Bool {
        return _finished
    }
    
    func executing(_ executing: Bool) {
        _executing = executing
    }
    
    func finish(_ finished: Bool) {
        _finished = finished
    }
    
    //MARK:- Main
    override func main() {
        //1.check if opertaion is cancelled then return immediately
        if isCancelled {
            finish(true)
            return
        }
        executing(true)
        //2. Downalod task
        imageDownloadTask()
    }
    
    //MARK:- Download image using URLSession downloadTask
    fileprivate func imageDownloadTask() {
        //image download task
        URLSession.shared.downloadTask(with: self.downloadImageURL) { [weak self](downloadedLocation, response, error) in
            //1. In case operation has been cancelled then return immediately
            if (self?.isCancelled)! {
                self?.executing(false)
                self?.finish(true)
                return
            }
            //2. check for downloaded image from server
            if let localURL = downloadedLocation, let imageData = try? Data(contentsOf: localURL), let image = UIImage(data: imageData) {
                self?.imageDownloadCompletionHandler?(image, (self?.downloadImageURL.absoluteString)!, (self?.indexPath)!,nil)
            }
            else {
                self?.imageDownloadCompletionHandler?(nil, (self?.downloadImageURL.absoluteString)!, (self?.indexPath)!,error ?? NSError(domain: Constants.User_Messages.serviceFailureErrorMessage, code: 0, userInfo: nil))
            }
            //3. Operation is completed, reset state of operation
            self?.executing(false)
            self?.finish(true)
        }.resume()
    }
}
