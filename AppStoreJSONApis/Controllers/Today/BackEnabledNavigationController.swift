//
//  BackEnabledNavigationController.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 6/13/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//

import UIKit


class BackEnabledNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    //MARK: - UIGestureRecognizerDelegate Methods
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.viewControllers.count > 1
    }
}
