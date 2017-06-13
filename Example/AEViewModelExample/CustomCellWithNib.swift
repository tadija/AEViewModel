//
//  CustomCellWithNib.swift
//  AEViewModelExample
//
//  Created by Marko Tadić on 4/23/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit
import AEViewModel

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
    
    override func updateUI(with item: Item) {
        if let data = item.data {
            title.text = data.title
            subtitle.text = data.detail
            if let imageName = data.image {
                customImageView.image = UIImage(named: imageName)
            }
        }
        let url = URL(string: "https://avatars1.githubusercontent.com/u/2762374")!
        customImageView?.setImage(from: url)
    }
    
}
