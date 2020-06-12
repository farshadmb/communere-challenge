//
//  UIViewController+ClassName.swift
//  commurnere-challenge
//
//  Created by Farshad Mousalou on 6/12/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// className of `UIViewController` class
    class var className: String {
        return String(describing: self)
    }
    
}
