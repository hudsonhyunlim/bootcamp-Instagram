//
//  Photo.swift
//  Instagram
//
//  Created by Hyun Lim on 2/12/16.
//  Copyright © 2016 Lyft. All rights reserved.
//

import Foundation

public class Photo {
    
    public var url: NSURL!
    
    init (photoDict: NSDictionary) {
        self.unpackDictionary(photoDict)
    }
    
    private func unpackDictionary(photoDict: NSDictionary) {
        let urlString = photoDict.valueForKeyPath("images.low_resolution.url") as! String
        self.url = NSURL(string: urlString)
    }
}