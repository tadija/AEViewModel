import UIKit

public enum TableModelCellStyle {
    case `default`
    case subtitle
    case leftDetail
    case rightDetail
    case rightSwitch
    case customClass(type: TableModelCell.Type)
    case customNib(nib: UINib?)
}
