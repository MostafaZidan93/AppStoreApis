//
//  AppFullScreenController.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 5/26/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//

import UIKit


class AppFullScreenController: UITableViewController {
    
    
    //MARK: - Vars
    var dismisHandler: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    
    //MARK: - TableView Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let headerCell = AppFullScreenHeaderCell()
            headerCell.closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
            return headerCell
        }
        
        let cell = AppFullScreenDescriptionCell()
        return cell
    }
    
    //Handle Dismiss for close button
    @objc func handleDismiss(button: UIButton) {
        print("Did Enter objc method")
        button.isHidden = true
        self.dismisHandler?()
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 450
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
}
