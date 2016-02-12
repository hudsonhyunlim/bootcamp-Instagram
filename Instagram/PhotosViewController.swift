//
//  ViewController.swift
//  Instagram
//
//  Created by Hyun Lim on 2/12/16.
//  Copyright © 2016 Lyft. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var photosApp: PhotosApp?

    @IBOutlet weak var photosTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // TODO: What is this magic?
        self.photosTableView.dataSource = self
        self.photosTableView.delegate = self
        self.photosTableView.rowHeight = 320
        
        self.photosApp = PhotosApp()
        self.photosApp?.retrievePhotos({() -> () in
            print(self.photosApp!.photos![0]["id"])
            self.photosTableView.reloadData()
        })
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.lyft.PhotoTableViewCell", forIndexPath: indexPath) as! PhotoTableViewCell
        let index = indexPath.row
        print(index)
        let photos = photosApp!.photos
        if(photosApp!.photos != nil) {
            print(photos![index]["id"])
            let photo = self.photosApp!.photos![index] as! NSDictionary
            let urlString = photo.valueForKeyPath("images.low_resolution.url") as! String
            let url = NSURL(string: urlString)
            cell.photoImageView.setImageWithURL(url!)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

