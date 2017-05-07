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
        
//        let settingsVC = RootSettingsTVC(style: .grouped, model: model)
//        let navigationVC = UINavigationController(rootViewController: settingsVC)
//        window?.rootViewController = navigationVC
        
        guard
            let nvc = window?.rootViewController as? UINavigationController,
            let tvc = nvc.viewControllers.first as? TableModelViewController
        else { return false }
        tvc.model = model
        
        return true
    }

}

// MARK: - Helpers

extension UIImageView {
    func setImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}
