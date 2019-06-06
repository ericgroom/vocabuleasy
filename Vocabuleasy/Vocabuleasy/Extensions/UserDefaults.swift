//
//  UserDefaults.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 6/6/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import Foundation

extension UserDefaults {
    func keyExists(_ key: String) -> Bool {
        return self.object(forKey: key) != nil
    }
}
