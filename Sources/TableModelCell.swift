import UIKit

public protocol TableModelCell: class {
    func configureUI()
    func updateUI(with item: Item)
}
