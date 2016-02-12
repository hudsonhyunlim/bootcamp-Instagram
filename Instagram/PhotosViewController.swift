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
        let photo = photosApp?.getPhoto(index)
        
        cell.photoImageView.setImageWithURL(photo!.url)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (photosApp?.getPhotoListSize())!
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        self.photosApp?.retrievePhotos({() -> () in
            self.photosTableView.reloadData()
            refreshControl.endRefreshing()
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        let vc = segue.destinationViewController as! PhotoDetailsViewController
        let indexPath = self.photosTableView.indexPathForCell(sender as! UITableViewCell)! as NSIndexPath
        let photo = photosApp?.getPhoto(indexPath.row)
        vc.setPhoto(photo!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        // TODO: do I need to clean anything up?
    }


}

