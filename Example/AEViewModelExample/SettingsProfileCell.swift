/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import AEViewModel

final class SettingsProfileCell: TableCellBasic {
    
    // MARK: Outlets
    
    let mainStack = UIStackView()
    let textStack = UIStackView()
    
    let profileImageView = UIImageView()
    let name = UILabel()
    let subtitle = UILabel()
    
    // MARK: TableCell
    
    override func customize() {
        configureHierarchy()
        configureLayout()
        configureAppearance()
    }
    
    override func update(with item: Item) {
        name.text = item.viewModel.title
        subtitle.text = item.viewModel.detail
        profileImageView.loadImage(from: URL(string: "https://avatars1.githubusercontent.com/u/2762374"))
    }
    
    // MARK: Helpers
    
    private func configureHierarchy() {
        textStack.addArrangedSubview(name)
        textStack.addArrangedSubview(subtitle)
        
        mainStack.addArrangedSubview(profileImageView)
        mainStack.addArrangedSubview(textStack)
        
        contentView.addSubview(mainStack)
    }
    
    private func configureLayout() {
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        mainStack.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        profileImageView.widthAnchor.constraint(equalToConstant: 56).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 56).isActive = true
    }
    
    private func configureAppearance() {
        let spacing: CGFloat = 12
        mainStack.axis = .horizontal
        mainStack.alignment = .center
        mainStack.isLayoutMarginsRelativeArrangement = true
        mainStack.layoutMargins = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        mainStack.spacing = spacing
        
        textStack.axis = .vertical
        
        profileImageView.layer.cornerRadius = 28
        profileImageView.layer.masksToBounds = true
        
        name.font = UIFont.preferredFont(forTextStyle: .title2)
        subtitle.font = UIFont.preferredFont(forTextStyle: .caption1)
    }
    
}
