//
//  TestTableViewController.swift
//  TestTruncatedLabel
//
//  Created by Viet Nguyen Tran on 6/23/17.
//  Copyright © 2017 iossimple. All rights reserved.
//

import UIKit

class TestTableViewController: UITableViewController {
    
    var data = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        data = [
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi.",
            "Sed ut perspiciatis unde omnis iste natus ",
            "Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot Europa usa li sam vocabular. Li lingues differe solmen in li grammatica, li pronunciation e li plu commun vocabules. Omnicos directe al desirabilite de un nov lingua franca: On refusa continuar payar custosi traductores.",
            "Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean. A small river named Duden flows by their place and supplies it with the necessary regelialia."
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

        cell.testText = data[indexPath.row]

        return cell
    }

}

extension TestTableViewController: TestTableViewCellProtocol {
    func requireReloadCell(cell: TestTableViewCell) {
        print("requireReloadCell")
        let indexPath = self.tableView.indexPath(for: cell)
        print("indexPath \(String(describing: indexPath))")
        if let indexPath = indexPath {
            print("run reload")
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}
