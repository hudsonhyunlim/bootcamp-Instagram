//
//  PhotoDetailsViewController.swift
//  Instagram
//
//  Created by Hyun Lim on 2/12/16.
//  Copyright © 2016 Lyft. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    private var photo: Photo?
    
    func setPhoto(photo: Photo) {
        self.photo = photo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.photoImageView.setImageWithURL(self.photo!.url)
    }
    
}
