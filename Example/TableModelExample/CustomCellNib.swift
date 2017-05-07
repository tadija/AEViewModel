//
//  CustomCellNib.swift
//  TableModelExample
//
//  Created by Marko Tadić on 4/23/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit
import TableModel

class CustomCellNib: UITableViewCell, TableModelCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var customImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        customImageView.layer.cornerRadius = 28
        customImageView.layer.masksToBounds = true
    }
    
    // MARK: - TableModelCell
    
    func configure(with item: Item) {
        customImageView.image = item.image
        title.text = item.title
        subtitle.text = item.detail
        
        let url = URL(string: "https://avatars1.githubusercontent.com/u/2762374")!
        customImageView?.setImage(from: url)
    }
    
}
