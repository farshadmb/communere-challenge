//
//  UIStoryboard+Naming.swift
//  commurnere-challenge
//
//  Created by Farshad Mousalou on 6/12/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    /// Storyboard Name
    ///
    /// - main: related to Main.storyboard
    enum Name: String, CaseIterable {
        /// related to Main.storyboard
        case main = "Main"
        case account = "Account"
    }
    
}
