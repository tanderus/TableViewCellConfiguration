//
//  ViewController.swift
//  TableViewCellConfiguration
//
//  Created by 6lackk@gmail.com on 04/13/2019.
//  Copyright (c) 2019 6lackk@gmail.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private var allRows = AllRows()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.allRows.startDisplayingOnTableView(self.tableView)
    }
}

