//
//  CustomCellWithNib.swift
//  TableExample
//
//  Created by Marko Tadić on 4/23/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit
import Table

class CustomCellWithNib: Cell.Basic {
    
    // MARK: - Outlets
    
    @IBOutlet weak var customImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    // MARK: - TableCell
    
    override func customizeUI() {
        customImageView.layer.cornerRadius = 28
        customImageView.layer.masksToBounds = true
    }
    
    override func updateUI(with item: ItemViewModel) {
        customImageView.image = UIImage(named: item.model.image)
        title.text = item.model.title
        subtitle.text = item.model.detail
        
        let url = URL(string: "https://avatars1.githubusercontent.com/u/2762374")!
        customImageView?.setImage(from: url)
    }
    
}
