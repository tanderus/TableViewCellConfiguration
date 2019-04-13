//
//  TextfieldCell.swift
//  TableViewCellConfiguration_Example
//
//  Created by Pavel Krasnobrovkin on 13/04/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import TableViewCellConfiguration

class TextfieldCell: UITableViewCell, ConfigurableCell {
    
    @IBOutlet private weak var textField: UITextField!
    
    func configureWithRow(_ row: TableRowProtocol) {
        guard let row = row as? TableRow else {
            return
        }
        
        guard case let .TextfieldRow(initialText) = row else {
            return
        }
        
        self.textField.text = initialText
    }
}
