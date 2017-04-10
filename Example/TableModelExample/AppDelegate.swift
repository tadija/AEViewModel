//
//  AppDelegate.swift
//  TableModelExample
//
//  Created by Marko Tadić on 4/8/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit
import TableModel

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let url = Bundle.main.url(forResource: "settings-menu", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let model = try! TableModel(jsonData: data)
        
        let delegate = TableModelDelegate()
        let menuVC = SettingsTableViewController(model: model, delegate: delegate)
        let navigationVC = UINavigationController(rootViewController: menuVC)
        
        window?.rootViewController = navigationVC
        
        return true
    }

}
