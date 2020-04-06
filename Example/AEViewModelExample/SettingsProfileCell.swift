/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright © 2017-2019 Marko Tadić
 *  Licensed under the MIT license
 */

import AEViewModel

final class SettingsProfileCell: TableCellBasic {

    // MARK: Outlets

    let mainStack = UIStackView()
    let textStack = UIStackView()

    let profileImageView = UIImageView()
    let name = UILabel()
    let subtitle = UILabel()

    // MARK: Override

    override func configure() {
        super.configure()

        configureHierarchy()
        configureLayout()
        configureAppearance()
    }

    override func update(with item: Item) {
        if let viewModel = item.viewModel as? BasicViewModel {
            name.text = viewModel.title
            subtitle.text = viewModel.detail
            profileImageView
                .loadImage(from: URL(string: "https://avatars1.githubusercontent.com/u/2762374"))
        }
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
        mainStack.layoutMargins = UIEdgeInsets(
            top: spacing, left: spacing, bottom: spacing, right: spacing
        )
        mainStack.spacing = spacing

        textStack.axis = .vertical

        profileImageView.layer.cornerRadius = 28
        profileImageView.layer.masksToBounds = true

        name.font = UIFont.preferredFont(forTextStyle: .title2)
        subtitle.font = UIFont.preferredFont(forTextStyle: .caption1)
    }

}
