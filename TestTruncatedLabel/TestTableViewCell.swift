//
//  TestTableViewCell.swift
//  TestTruncatedLabel
//
//  Created by Viet Nguyen Tran on 6/23/17.
//  Copyright © 2017 iossimple. All rights reserved.
//

import UIKit

protocol TestTableViewCellProtocol: class {
    func cellDidPressSeemore(cell: TestTableViewCell)
    func cellDidPressTextContent(cell: TestTableViewCell)
}

class TestTableViewCell: UITableViewCell {
    
    weak var delegate: TestTableViewCellProtocol?

    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var seeMoreButton: UIButton!
    @IBAction func pressSeemore(_ sender: Any) {
        delegate?.cellDidPressSeemore(cell: self)
    }
    
    override func awakeFromNib() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(tap:)))
        testLabel.addGestureRecognizer(tap)
        testLabel.isUserInteractionEnabled = true
    }
    
    @objc private func handleTap(tap: UITapGestureRecognizer) {
        delegate?.cellDidPressTextContent(cell: self)
    }
    
    var testText: String = "" {
        didSet {
            testLabel.text = testText
        }
    }

    func truncateLabel() {
        testLabel.numberOfLines = 3
    }
    
    func showFullLabel() {
        testLabel.numberOfLines = 0
    }
    
    var isTextTruncated: Bool {
        return testLabel.isTruncated()
    }
    
    func showSeemore() {
        seeMoreButton.isHidden = false
    }
    
    func hideSeemore() {
        seeMoreButton.isHidden = true
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
