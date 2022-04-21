//
//  Created by Anton Dityativ on 15/11/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import Foundation

extension Bundle {
    var appIdentifier: String? {
        guard let identifier = infoDictionary?[kCFBundleIdentifierKey as String] as? String else {
            return nil
        }
        return identifier
    }

    var appName: String? {
        guard let name = infoDictionary?[kCFBundleNameKey as String] as? String else {
            return nil
        }
        return name
    }

    var appDisplayName: String? {
        guard let displayName = infoDictionary?["CFBundleDisplayName" as String] as? String else {
            return nil
        }
        return displayName
    }

    var appVersion: String? {
        guard let version = infoDictionary?["CFBundleShortVersionString" as String] as? String else {
            return nil
        }
        return version
    }

    var bundleVersion: String? {
        guard let version = infoDictionary?["CFBundleVersion" as String] as? String else {
            return nil
        }
        return version
    }
}
