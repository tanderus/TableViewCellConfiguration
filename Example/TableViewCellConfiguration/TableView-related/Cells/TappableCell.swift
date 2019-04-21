//
//  TappableCell.swift
//  TableViewCellConfiguration_Example
//
//  Created by Pavel Krasnobrovkin on 13/04/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import TableViewCellConfiguration

final class TappableCell: UITableViewCell, ConfigurableCell {
    
    @IBOutlet private weak var label: UILabel!
    
    func configureWithRow(_ row: TableRowProtocol) {
        guard let row = row as? TableRow else {
            return
        }
        
        guard case let .TappableRow(text, _) = row else {
            return
        }
        
        self.label.text = text
    }
}
