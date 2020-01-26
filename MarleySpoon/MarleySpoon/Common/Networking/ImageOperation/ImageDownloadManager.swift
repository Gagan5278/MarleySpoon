//
//  ImageDownloadManager.swift
//  BitPanda
//
//  Created by Gagan Vishal on 2020/01/25.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
import UIKit

typealias ImageDownloadCompletionHandler = (_ image: UIImage?, _ imageURLString: String, _ indexPath: IndexPath, _ error: Error?) -> Void

class ImageDownloadManager {
    //shared instance of the class
    static let sharedInsatnce = ImageDownloadManager()
    //A cache to store downloaded images against image URL String
    var downloadedImageCache = NSCache<NSString, UIImage>()
    //create an opeartion queue
    var imageDownloadQueue: OperationQueue =  {
        var operationQueue = OperationQueue()
        operationQueue.name = "com.MarleySpoon.imageDownload"
        return operationQueue
    }()
    //completion handler Object
    private var completionHandler: ImageDownloadCompletionHandler?
    
    //MARK:- Download image. This func will be used in downloading thumbnail as well as largee images
    /// - Parameters:
    ///   - indexPath: indexPath for current cell
    ///   - ContributorsModel: an  object of ContributorsModel
    ///   - completioinHandler: escaping completionHandler for downloaded image
    func downloadUserAvtarImage(at indexPath: IndexPath = IndexPath(row: 0, section: 0), avatar_url: String, completioinHandler: @escaping ImageDownloadCompletionHandler) {
        self.completionHandler = completioinHandler
        //get requested image url
        let imageURLString = avatar_url
        //check if image exist in cache
        if let availableImage = self.downloadedImageCache.object(forKey: imageURLString as NSString) {
            self.completionHandler?(availableImage, imageURLString, indexPath,nil)
            return
        }
        ///Image not available in cache, download from server
        ///check whethee image download is already progresss. If it is already in download process, make priority high
        if let operation = ((imageDownloadQueue.operations as? [ImageOperation])?.first(where: {$0.downloadImageURL.absoluteString == imageURLString})), operation.isExecuting {
            operation.queuePriority = .veryHigh
        }
        else {
            if let imageURL = URL(string: imageURLString) {
                let imageOperation =  ImageOperation(indexPath: indexPath, url: imageURL)
                imageOperation.imageDownloadCompletionHandler = {(image, url,indexPath,error) in
                    if let imageDownloaded = image {
                        self.downloadedImageCache.setObject(imageDownloaded, forKey: url as NSString)
                    }
                    self.completionHandler?(image, url, indexPath,error)
                }
                imageDownloadQueue.addOperation(imageOperation)
            }
        }
    }
}
