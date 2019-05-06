//
//  ReviewScheduler.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/4/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import Foundation

protocol ReviewScheduler {
    func schedule(session: ReviewSessionLog)
}
