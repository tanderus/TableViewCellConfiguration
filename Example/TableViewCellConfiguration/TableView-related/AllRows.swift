//
//  AllRows.swift
//  TableViewCellConfiguration_Example
//
//  Created by Pavel Krasnobrovkin on 13/04/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import TableViewCellConfiguration

final class AllRows: AllTableRows {
    
    init() {
        super.init([
            TableRow.LabelRow(text: "First label row")
            , TableRow.TappableRow(text: "Hey there! You can tap me"
                , tapHandler: { print("Hello world from tap 1") }
            )
            , TableRow.TextfieldRow(initialText: "Initial text for 1")
            , TableRow.TappableRow(text: "Expand/collapse is supported. Tap to check"
                , tapHandler: { print("Expand/collapse cell tapped") }
            )
            , TableRow.LabelRow(text: "I believe I can hide...")
            , TableRow.LabelRow(text: "Me too!")
            , TableRow.LabelRow(text: "And I won't hide! I promise!")
            ]
        )
        
        self.addExpandCollapseRoute(3, indicesToCollapse: [4, 5])
    }
}
