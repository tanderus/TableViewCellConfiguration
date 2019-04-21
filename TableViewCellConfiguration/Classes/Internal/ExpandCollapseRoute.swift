//
//  ExpandCollapseRoute.swift
//  TableViewCellConfiguration
//
//  Created by Pavel Krasnobrovkin on 21/04/2019.
//

import Foundation

internal struct ExpandCollapseRoute {
    
    let indexToTap: UInt
    let indicesToCollapse: Set<UInt>
    let isExpanded: Bool
    
    init(indexToTap: UInt, indicesToCollapse: Set<UInt>, isExpanded: Bool) {
        guard !indicesToCollapse.contains(indexToTap) else {
            fatalError("Can't collapse the row '\(indexToTap)' itself after tapping on it")
        }
        
        self.indexToTap = indexToTap
        self.indicesToCollapse = indicesToCollapse
        self.isExpanded = isExpanded
    }
}

extension ExpandCollapseRoute {
    
    var inversedByIsExpanded: ExpandCollapseRoute {
        return ExpandCollapseRoute(
            indexToTap: self.indexToTap
            , indicesToCollapse: self.indicesToCollapse
            , isExpanded: !self.isExpanded
        )
    }
}

extension ExpandCollapseRoute: Hashable {
    
    static func == (lhs: ExpandCollapseRoute, rhs: ExpandCollapseRoute) -> Bool {
        return lhs.indexToTap == rhs.indexToTap &&
            lhs.indicesToCollapse == rhs.indicesToCollapse &&
            lhs.isExpanded == rhs.isExpanded
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.indexToTap)
        hasher.combine(self.indicesToCollapse)
        hasher.combine(self.isExpanded)
    }
}
