import UIKit

public enum TableModelCellStyle {
    case basic
    case subtitle
    case leftDetail
    case rightDetail
    case toggle
    case customClass(type: TableModelCell.Type)
    case customNib(nib: UINib?)
}
