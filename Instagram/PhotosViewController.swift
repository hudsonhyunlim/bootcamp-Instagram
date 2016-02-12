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
        
        // attach refresh
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        self.photosTableView.insertSubview(refreshControl, atIndex: 0)
        
        // init app
        self.photosApp = PhotosApp()
        self.photosApp?.retrievePhotos({() -> () in
            self.photosTableView.reloadData()
        })
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.lyft.PhotoTableViewCell", forIndexPath: indexPath) as! PhotoTableViewCell
        let index = indexPath.row
        let photos = photosApp!.photos
        if (photos != nil) {
            let photo = self.photosApp!.photos![index] as! NSDictionary
            let urlString = photo.valueForKeyPath("images.low_resolution.url") as! String
            let url = NSURL(string: urlString)
            cell.photoImageView.setImageWithURL(url!)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let photos = photosApp!.photos
        if (photos != nil) {
            return photos!.count
        } else {
            return 0
        }
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        self.photosApp?.retrievePhotos({() -> () in
            self.photosTableView.reloadData()
            refreshControl.endRefreshing()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        // TODO: do I need to clean anything up?
    }


}

