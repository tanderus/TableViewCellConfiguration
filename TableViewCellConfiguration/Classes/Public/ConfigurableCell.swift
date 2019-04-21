//
//  ConfigurableCell.swift
//  CellConfiguration
//
//  Created by Pavel Krasnobrovkin on 10/04/2019.
//  Copyright © 2019 Pavel Krasnobrovkin. All rights reserved.
//

import Foundation

public protocol ConfigurableCell where Self: UITableViewCell {
    
    func configureWithRow(_ row: TableRowProtocol)
}
