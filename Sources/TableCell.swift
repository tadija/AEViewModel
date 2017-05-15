import UIKit

public protocol TableCell: class {
    func configureUI()
    func updateUI(with item: Item)
}
