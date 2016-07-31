//
//  AdsListUITableViewCell.swift
//  OLXChallenge
//
//  Created by Pedro Brito on 30/07/16.
//  Copyright © 2016 Pedro Brito. All rights reserved.
//

import UIKit

class AdsListUITableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var userLabel: UILabel?
    @IBOutlet weak var priceLabel: UILabel?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor.clearColor()
    }
    
    func setAdInfo(viewModel: AdViewModel){
        self.titleLabel?.text = viewModel.title;
        self.userLabel?.text = viewModel.user_label;
        self.priceLabel?.text = String(format: "%@ €", (viewModel.price_numeric == nil ? "" : viewModel.price_numeric!));
    }
    
}
