import UIKit

public protocol TableViewControllerDelegate: class {
    func cellType(forIdentifier identifier: String) -> UITableViewCell.Type?
}

open class TableViewController: UITableViewController {
    
    let table: Table
    
    public weak var delegate: TableViewControllerDelegate?
    
    public init(table: Table, style: UITableViewStyle = .grouped, delegate: TableViewControllerDelegate) {
        self.table = table
        self.delegate = delegate
        
        super.init(style: style)
        
        self.title = table.data?["title"] as? String
        registerCells()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func registerCells() {
        table.sections.forEach { section in
            section.items.forEach { item in
                registerCell(with: item)
            }
        }
    }
    
    private func registerCell(with item: Item) {
        if let cellType = delegate?.cellType(forIdentifier: item.identifier) {
            tableView.register(cellType.self, forCellReuseIdentifier: item.identifier)
        } else {
            if let styleIdentifier = item.style, let style = ItemStyle(rawValue: styleIdentifier) {
                switch style {
                case .subtitle:
                    tableView.register(SubtitleCell.self, forCellReuseIdentifier: item.identifier)
                default:
                    tableView.register(UITableViewCell.self, forCellReuseIdentifier: item.identifier)
                }
            } else {
                tableView.register(UITableViewCell.self, forCellReuseIdentifier: item.identifier)
            }
        }
    }
    
}

extension TableViewController {
    open override func numberOfSections(in tableView: UITableView) -> Int {
        return table.sections.count
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return table.sections[section].items.count
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = table.sections[indexPath.section].items[indexPath.item]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath)
        
        if let cell = cell as? TableCell {
            cell.configure(with: item)
        } else {
            cell.imageView?.image = UIImage(named: item.image ?? "")
            cell.textLabel?.text = item.title
            cell.detailTextLabel?.text = item.detail
        }
        
        return cell
    }
    
    open override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return table.sections[section].data?["header-title"] as? String
    }
}
