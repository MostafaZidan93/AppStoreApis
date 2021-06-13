//
//  AppFullScreenController.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 5/26/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//'statusBarFrame' was deprecated in iOS 13.0: Use the statusBarManager property of the window scene instead.
//UIApplication.shared.windows[0].windowScene?.statusBarManager?.statusBarFrame.height

import UIKit


class AppFullScreenController: UITableViewController {
    
    
    //MARK: - Vars
    var dismisHandler: (() -> ())?
    var todayItem: TodayItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
        let height = UIApplication.shared.windows[0].windowScene?.statusBarManager?.statusBarFrame.height
        tableView.contentInset = .init(top: 0, left: 0, bottom: height!, right: 0)
    }
    
    
    //MARK: - TableView Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let headerCell = AppFullScreenHeaderCell()
            headerCell.closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
            headerCell.todayCell.todayItem = todayItem
            headerCell.todayCell.layer.cornerRadius = 0
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
            return TodayController.cellSize
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
}
