//
//  TestTableViewCell.swift
//  TestTruncatedLabel
//
//  Created by Viet Nguyen Tran on 6/23/17.
//  Copyright © 2017 iossimple. All rights reserved.
//

import UIKit

protocol TestTableViewCellProtocol: class {
    func requireReloadCell(cell: TestTableViewCell)
}

class TestTableViewCell: UITableViewCell {
    
    weak var delegate: TestTableViewCellProtocol?

    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var seeMoreButton: UIButton!
    @IBAction func pressSeemore(_ sender: Any) {
        print("press Seemore")
        testLabel.numberOfLines = 0
        delegate?.requireReloadCell(cell: self)
    }
    
    override func awakeFromNib() {
        testLabel.numberOfLines = 2
    }
    
    var testText: String = "" {
        didSet {
            testLabel.text = testText
            
            seeMoreButton.isHidden = !testLabel.isTruncated()
        }
    }

}

extension UILabel {
    func isTruncated() -> Bool {
        
        if let string = self.text {
            
            let size: CGSize = (string as NSString).boundingRect(
                with: CGSize(width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude),
                options: NSStringDrawingOptions.usesLineFragmentOrigin,
                attributes: [NSFontAttributeName: self.font],
                context: nil).size
            
            return (size.height > self.bounds.size.height)
        }
        
        return false
    }
}
