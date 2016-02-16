//
//  PhotosApp.swift
//  Instagram
//
//  Created by Hyun Lim on 2/12/16.
//  Copyright © 2016 Lyft. All rights reserved.
//

import Foundation

public final class PhotosApp {
    
    private let CLIENT_ID = "e05c462ebd86446ea48a5af73769b602"
    
    public var photos:NSArray
    public var isDataLoading = false
    
    init () {
        self.photos = []
    }
    
    public func resetPhotos(completion: (success: Bool)->()) {
        if (self.isDataLoading) {
            completion(success: false)
        } else {
            self.retrievePhotos({ (photos: NSArray)->() in
                if (photos.count > 0) {
                    self.photos = photos
                }
                completion(success: true)
            })
        }
    }
    
    public func getMorePhotos(completion: (success: Bool)->()) {
        if (self.isDataLoading) {
            completion(success: false)
        } else {
            self.retrievePhotos({ (photos: NSArray)->() in
                if (photos.count > 0) {
                    self.photos = self.photos.arrayByAddingObjectsFromArray(photos as [AnyObject])
                }
                completion(success: true)
            })
        }
    }
    
    private func retrievePhotos(completion: (photos: NSArray)->()) {
        self.isDataLoading = true
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(self.CLIENT_ID)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            let photos = responseDictionary["data"] as! NSArray
                            self.isDataLoading = false
                            completion(photos: photos)
                    }
                }
        });
        task.resume()
    }
    
    public func getPhoto(index: Int) -> Photo {
        return Photo(photoDict: self.photos[index] as! NSDictionary)
    }
    
    public func getPhotoListSize() -> Int {
        return self.photos.count
    }
}