//
//  AllRows.swift
//  TableViewCellConfiguration_Example
//
//  Created by Pavel Krasnobrovkin on 13/04/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import TableViewCellConfiguration

final class AllRows: AllTableRows {
    
    override init() {
        super.init()
        
        self.allObjects = [
            TableRow.LabelRow(text: "First label row")
            , TableRow.TappableRow(tapHandler: { print("Hello world from tap 1") })
            , TableRow.TextfieldRow(initialText: "Initial text for 1")
        ]
    }
}
