# TableViewCellConfiguration

A simple lightweight utility for one-sectioned UITableView declarative configuration.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

TableViewCellConfiguration is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TableViewCellConfiguration', :git => "https://github.com/tanderus/TableViewCellConfiguration"
```



## How To Use

You will need to Adopt 3 entities in your project:

1. TableRowProtocol
2. ConfigurableCell protocol
3. AllTableRows class



## TableRowProtocol

This is an abstraction of cells used by this library.

A typical approach would be creating an enum with associated values (if you need):

```swift
import TableViewCellConfiguration

enum MyTableRow: TableRowProtocol {
    
    case LabelRow(text: String)
    case TextfieldRow(initialText: String)
    case TappableRow(tapHandler: TapHandler)
    
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
        guard case let TableRow.TappableRow(tapHandler) = self else {
            return nil
        }
        
        return tapHandler
    }
}

```



, then

## ConfigurableCell 

Define your UITableViewCell subclasses and implement the `configureWithRow(_ row: TableRowProtocol)` method like this

```swift
import UIKit
import TableViewCellConfiguration

class LabelTableViewCell: UITableViewCell, ConfigurableCell {
    
    @IBOutlet private weak var label: UILabel!
    
    func configureWithRow(_ row: TableRowProtocol) {
        guard let row = row as? MyTableRow else {
            return
        }
        
        guard case let .LabelRow(text) = row else {
            return
        }
        
        self.label.text = text
    }
}
```

, and finally

## AllTableRows

This one puts everything in place and contains all the boilerplate code of `UITableViewDatasource` and `UITableViewDelegate` methods.

A typical approach would be subclassing it. 

All you need to do is:

1.  manage the contents of `var allObjects: [TableRowProtocol]`  variable;
2.  call the `startDisplayingOnTableView(_ tableView: UITableView)` at some point. It just assigns datasource and delegate tableView properties on itself;



#### Expand/Collapse is done via

`func addExpandCollapseRoute(_ indexToTap: UInt, indicesToCollapse: Set<UInt>)` method.

Notes:

- all indices start from zero;
- `indexToTap` can't be within `indicesToCollapse` set;

## Author

tanderus, 6lackk@gmail.com

## License

TableViewCellConfiguration is available under the MIT license. See the LICENSE file for more info.
