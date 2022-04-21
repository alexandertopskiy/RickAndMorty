//
//  Created by Anton Dityativ on 15/11/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import UIKit

final class AppConfigurator {
    static func configure(_ application: UIApplication, with launchOptions: LaunchOptions?) {
        if let appVersion = Bundle.main.appVersion, let bundleVersion = Bundle.main.bundleVersion {
            let appVersion = "\(appVersion) (\(bundleVersion))"
            UserDefaults.standard.appVersion = appVersion
        }
    }
}

private extension UserDefaults {
    var appVersion: String? {
        get {
            return string(forKey: #function)
        }
        set {
            set(newValue, forKey: #function)
        }
    }
}
