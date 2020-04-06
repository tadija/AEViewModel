/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright © 2017-2019 Marko Tadić
 *  Licensed under the MIT license
 */

import AEViewModel

final class GithubRepoCell: TableCellBasic {

    // MARK: Outlets

    @IBOutlet weak var ownerImage: UIImageView!
    @IBOutlet weak var ownerUsername: UILabel!
    @IBOutlet weak var repoUpdateDate: UILabel!
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    @IBOutlet weak var forks: UILabel!
    @IBOutlet weak var stars: UILabel!

    // MARK: Override

    override func configure() {
        super.configure()

        accessoryType = .disclosureIndicator
        ownerImage.layer.cornerRadius = 32
        ownerImage.layer.masksToBounds = true
    }

    override func update(with item: Item) {
        if let repo = item.viewModel as? Repo {
            ownerImage.loadImage(from: repo.ownerImageURL)
            ownerUsername.text = "@\(repo.owner.username)"
            repoUpdateDate.text = repo.updatedFormatted
            repoName.text = repo.name
            repoDescription.text = repo.description
            forks.text = "⋔ \(repo.forksCount)"
            stars.text = "★ \(repo.starsCount)"
        }
    }

}
