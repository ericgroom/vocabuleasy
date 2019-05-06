//
//  NotificationService.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/6/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class NotificationService {
    private init() {}
    
    static func showSuccessBanner(withText text: String = "Success!") {
        let banner = NotificationBanner(title: text)
        banner.duration = 1.0
        banner.applyStyling(cornerRadius: 8.0)
        banner.show()
    }
    
    static func showErrorBanner(withText text: String = "Unknown Error") {
        let banner = NotificationBanner(title: text, style: .danger)
        banner.duration = 1.0
        banner.applyStyling(cornerRadius: 8.0)
        banner.show()
    }
}

