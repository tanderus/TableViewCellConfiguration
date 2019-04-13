//
//  TableRowProtocol.swift
//  CellConfiguration
//
//  Created by Pavel Krasnobrovkin on 10/04/2019.
//  Copyright © 2019 Pavel Krasnobrovkin. All rights reserved.
//

import UIKit

public protocol TableRowProtocol {
    
    typealias TapHandler = () -> Void
    
    var cellReuseIdentifier: String { get }
    var recommendedHeight: CGFloat { get }
    
    var isSelectable: Bool { get }
    var cellTapHandler: TapHandler? { get }
}

public extension TableRowProtocol {
    
    var isSelectable: Bool {
        return false
    }
    
    var cellTapHandler: TapHandler? {
        return nil
    }
}
