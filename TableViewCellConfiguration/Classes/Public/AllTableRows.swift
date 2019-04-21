//
//  AllTableRows.swift
//  CellConfiguration
//
//  Created by Pavel Krasnobrovkin on 10/04/2019.
//  Copyright © 2019 Pavel Krasnobrovkin. All rights reserved.
//

import UIKit

open class AllTableRows: NSObject {
    
    public func startDisplayingOnTableView(_ tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    public init(_ allObjects: [TableRowProtocol] = []) {
        self.allObjects = allObjects
    }
    
    public func addExpandCollapseRoute(_ indexToTap: UInt, indicesToCollapse: Set<UInt>) {
        self.expandCollapseRoutes.insert(
            ExpandCollapseRoute(indexToTap: indexToTap, indicesToCollapse: indicesToCollapse, isExpanded: true)
        )
    }
    
    var allObjects: [TableRowProtocol] = []
    var expandCollapseRoutes = Set<ExpandCollapseRoute>()
    
    internal var alreadyCollapsedRoutes: Set<ExpandCollapseRoute> {
        return expandCollapseRoutes.filter { !$0.isExpanded }
    }
    
    internal var alreadyCollapsedRowIndicesAsc: [UInt] {
        let alreadyCollapsedRowIndices = self.alreadyCollapsedRoutes
            .map { $0.indicesToCollapse }
            .reduce(Set()) { $0.union($1) }
        
        let asArray: [UInt] = alreadyCollapsedRowIndices.map { $0 }
        return asArray.sorted(by: <)
    }
    
    internal var allNotCollapsedRows: [TableRowProtocol] {
        var result = self.allObjects
        self.alreadyCollapsedRowIndicesAsc
            .reversed()
            .forEach { result.remove(at: Int($0)) }
        
        return result
    }
    
    internal func originalIndexBasedOn(_ index: Int) -> Int {
        let nIndicesBefore = alreadyCollapsedRowIndicesAsc.filter { $0 <= index }.count
        return index + nIndicesBefore
    }
}


extension AllTableRows: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allNotCollapsedRows.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.allNotCollapsedRows[indexPath.row]
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
        
        let idx = indexPath.row
        let originalIndex = originalIndexBasedOn(idx)
        
        if let route = self.expandCollapseRoutes.first(where: { $0.indexToTap == originalIndex }) {
            let wasExpanded = route.isExpanded
            self.expandCollapseRoutes.remove(route)
            self.expandCollapseRoutes.insert(route.inversedByIsExpanded)
            
            let nIndicesBeforeTapped = self.alreadyCollapsedRowIndicesAsc.filter { $0 <= idx }.count
            let indicesToAlter = route.indicesToCollapse.map { Int($0) - nIndicesBeforeTapped }
            let indexPaths = indicesToAlter.map { IndexPath(row: $0, section: 0) }
            if wasExpanded
            {
                tableView.deleteRows(at: indexPaths, with: .top)
            }
            else {
                tableView.insertRows(at: indexPaths, with: .top)
                guard let visible = tableView.indexPathsForVisibleRows else { return }
                
                let firstNew = indexPaths.first!
                let notVisible = nil == visible.first(where: { $0.row == firstNew.row })
                if notVisible
                {
                    tableView.scrollToRow(at: firstNew, at: .top, animated: true)
                }
            }
        }
        
        let row = self.allNotCollapsedRows[idx]
        if row.isSelectable { row.cellTapHandler?() }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.recommendedHeightForRowAt(indexPath)
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.recommendedHeightForRowAt(indexPath)
    }
    
    private func recommendedHeightForRowAt(_ indexPath: IndexPath) -> CGFloat {
        let row = self.allNotCollapsedRows[indexPath.row]
        return row.recommendedHeight
    }
}
