//
//  ViewController.swift
//  Instagram
//
//  Created by Hyun Lim on 2/12/16.
//  Copyright © 2016 Lyft. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    private var photosApp: PhotosApp?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.photosApp = PhotosApp()
        self.photosApp?.retrievePhotos({() -> () in
            print(self.photosApp!.photos![0]["id"])
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

