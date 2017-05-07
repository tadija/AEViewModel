//
//  CustomCellClass.swift
//  TableModelExample
//
//  Created by Marko Tadić on 4/23/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit
import TableModel

class CustomCellClass: UITableViewCell, TableModelCell {
    
    // MARK: - Init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        let url = URL(string: "https://avatars1.githubusercontent.com/u/2762374")!
        imageView?.setImage(from: url)
        
        textLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .caption1)
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let width = imageView?.bounds.size.width ?? 0
        imageView?.layer.cornerRadius = width / 2
        imageView?.layer.masksToBounds = true
    }
    
}
