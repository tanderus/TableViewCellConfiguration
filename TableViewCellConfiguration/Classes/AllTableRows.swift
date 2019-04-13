//
//  AllTableRows.swift
//  CellConfiguration
//
//  Created by Pavel Krasnobrovkin on 10/04/2019.
//  Copyright © 2019 Pavel Krasnobrovkin. All rights reserved.
//

import UIKit

open class AllTableRows: NSObject {
    
    public var allObjects: [TableRowProtocol] = []
    
    public func startDisplayingOnTableView(_ tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
    }
}


extension AllTableRows: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allObjects.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = self.allObjects[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: row.cellReuseIdentifier, for: indexPath)
        if let cell = cell as? ConfigurableCell {
            cell.selectionStyle = row.isSelectable ? .default : .none
            cell.configureWithRow(row)
        }
        
        return cell
    }
}

extension AllTableRows: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = self.allObjects[indexPath.row]
        row.cellTapHandler?()
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.recommendedHeightForRowAt(indexPath)
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.recommendedHeightForRowAt(indexPath)
    }
    
    func recommendedHeightForRowAt(_ indexPath: IndexPath) -> CGFloat {
        let row = self.allObjects[indexPath.row]
        return row.recommendedHeight
    }
}
