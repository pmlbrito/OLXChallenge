//
//  AdsListTableViewController.swift
//  OLXChallenge
//
//  Created by Pedro Brito on 30/07/16.
//  Copyright © 2016 Pedro Brito. All rights reserved.
//

import UIKit
import QuickShotUtils

class AdsListTableViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    
    var process: AdsListProcess?;
    var adsLoaded: [AdViewModel]?;
    

    override func viewDidLoad() {
        super.viewDidLoad();
        
        //start loading ads
        process = AdsListProcess();
        
        SimpleLoadingIndicator.shared.show();
        
        process?.getAds("25", completionHandler: { (availAds) in
            
            self.adsLoaded = availAds;
            
            SimpleLoadingIndicator.shared.hide();
            
            self.tableView.reloadData();
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension AdsListTableViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adsLoaded == nil ? 0 : adsLoaded!.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(isNilOrEmpty(self.adsLoaded)){
            return UITableViewCell();
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("AdsListUITableViewCell", forIndexPath: indexPath) as! AdsListUITableViewCell
        
        let viewModel = self.adsLoaded![indexPath.row];
        cell.setAdInfo(viewModel);
        
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.whiteColor() : UIColor(hexString: "#EEEEEEFF")
        
        return cell
    }
}

extension AdsListTableViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //print("You selected cell #\(indexPath.row)!")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "AdListToDetailSegue" {
            // Setup new view controller
            let cell = sender as! AdsListUITableViewCell
            
            let indexPath = self.tableView.indexPathForCell(cell);
            
            let viewModel = self.adsLoaded![indexPath!.row];
            
            let nextVC = segue.destinationViewController as! AdDetailUIViewController;
            nextVC.setDetailViewData(viewModel);
        }
        
        if segue.identifier == "AdListToDetailPagerSegue" {
            // Setup new view controller
            let cell = sender as! AdsListUITableViewCell
            
            let indexPath = self.tableView.indexPathForCell(cell);
            
            let nextVC = segue.destinationViewController as! AdsPagerViewController;
            nextVC.setPagerData(self.adsLoaded, initialViewIndex: (indexPath?.row)!);
        }
    }
}