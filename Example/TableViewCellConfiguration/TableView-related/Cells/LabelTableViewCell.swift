//
//  LabelTableViewCell.swift
//  TableViewCellConfiguration_Example
//
//  Created by Pavel Krasnobrovkin on 13/04/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import TableViewCellConfiguration

class LabelTableViewCell: UITableViewCell, ConfigurableCell {
    
    @IBOutlet private weak var label: UILabel!
    
    func configureWithRow(_ row: TableRowProtocol) {
        guard let row = row as? TableRow else {
            return
        }
        
        guard case let .LabelRow(text) = row else {
            return
        }
        
        self.label.text = text
    }
}

