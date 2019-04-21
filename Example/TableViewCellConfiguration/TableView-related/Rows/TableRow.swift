//
//  TableRow.swift
//  TableViewCellConfiguration_Example
//
//  Created by Pavel Krasnobrovkin on 13/04/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import TableViewCellConfiguration

enum TableRow: TableRowProtocol {
    
    case LabelRow(text: String)
    case TextfieldRow(initialText: String)
    case TappableRow(text: String, tapHandler: TapHandler)
    
    var cellReuseIdentifier: String {
        switch self {
        case .LabelRow:
            return String(describing: LabelTableViewCell.self)
        case .TextfieldRow:
            return String(describing: TextfieldCell.self)
        case .TappableRow:
            return String(describing: TappableCell.self)
        }
    }
    
    var recommendedHeight: CGFloat {
        switch self {
        case .LabelRow:
            fallthrough
        case .TextfieldRow:
            return 44
        case .TappableRow:
            return 120
        }
    }
    
    var isSelectable: Bool {
        guard case .TappableRow = self else {
            return false
        }
        
        return true
    }
    
    var cellTapHandler: TapHandler? {
        guard case let TableRow.TappableRow(_, tapHandler) = self else {
            return nil
        }
        
        return tapHandler
    }
}
