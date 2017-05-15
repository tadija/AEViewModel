import UIKit

public enum TableCellStyle {
    case basic
    case subtitle
    case leftDetail
    case rightDetail
    case toggle
    case customClass(type: TableCell.Type)
    case customNib(nib: UINib?)
}
