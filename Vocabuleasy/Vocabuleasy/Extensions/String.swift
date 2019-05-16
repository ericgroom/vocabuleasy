//
//  String.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/16/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import Foundation

extension String {
    func trim(includesNewlines: Bool = true) -> String {
        if includesNewlines {
            return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        } else {
            return self.trimmingCharacters(in: CharacterSet.whitespaces)
        }
    }
}
