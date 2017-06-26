//
//  TestTableViewController.swift
//  TestTruncatedLabel
//
//  Created by Viet Nguyen Tran on 6/23/17.
//  Copyright © 2017 iossimple. All rights reserved.
//

import UIKit

class CellData {
    var text: String = ""
    var state: Int = 0
    var isDisplayed: Bool = false
    var isExpandable: Bool = false
    
    init(text: String, isDisplayed: Bool, state: Int, isExpandable: Bool) {
        self.text = text
        self.state = state
        self.isExpandable = isExpandable
        self.isDisplayed = isDisplayed
    }
}

class TestTableViewController: UITableViewController {
    
    var data = [CellData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let text_1 = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi."
        let text_2 = "Sed ut perspiciatis unde omnis iste natus "
        let text_3 = "Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot Europa usa li sam vocabular. Li lingues differe solmen in li grammatica, li pronunciation e li plu commun vocabules. Omnicos directe al desirabilite de un nov lingua franca: On refusa continuar payar custosi traductores."
        let text_4 = "Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean. A small river named Duden flows by their place and supplies it with the necessary regelialia."

        data = [
            CellData(text: text_1, isDisplayed: false, state: 0, isExpandable: false),
            CellData(text: text_2, isDisplayed: false, state: 0, isExpandable: false),
            CellData(text: text_3, isDisplayed: false, state: 0, isExpandable: false),
            CellData(text: text_4, isDisplayed: false, state: 0, isExpandable: false)
        ]
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TestTableViewCell
        cell.delegate = self

        let dataToDisplay = data[indexPath.row]
        cell.testText = dataToDisplay.text
        
        if !dataToDisplay.isDisplayed { // first time display
            dataToDisplay.isDisplayed = true
            cell.truncateLabel()
            dataToDisplay.isExpandable = cell.isTextTruncated
            if dataToDisplay.isExpandable {
                cell.showSeemore()
            } else {
                cell.hideSeemore()
            }
        } else { // second time display and go on
            if dataToDisplay.state == 0 {
                cell.truncateLabel()
                if dataToDisplay.isExpandable {
                    cell.showSeemore()
                } else {
                    cell.hideSeemore()
                }
            } else {
                cell.showFullLabel()
                cell.hideSeemore()
            }
        }

        return cell
    }

}

extension TestTableViewController: TestTableViewCellProtocol {
    func cellDidPressSeemore(cell: TestTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let dataToDisplay = data[indexPath.row]
            if dataToDisplay.isExpandable && dataToDisplay.state == 0 {
                dataToDisplay.state = 1
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    func cellDidPressTextContent(cell: TestTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let dataToDisplay = data[indexPath.row]
            if dataToDisplay.isExpandable {
                dataToDisplay.state = dataToDisplay.state == 0 ? 1 : 0
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
}
