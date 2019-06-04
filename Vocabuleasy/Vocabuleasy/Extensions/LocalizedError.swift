//
//  LocalizedError.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 6/4/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import Foundation

extension LocalizedError where Self: CustomStringConvertible {
    public var localizedDescription: String {
        return self.description
    }
}
