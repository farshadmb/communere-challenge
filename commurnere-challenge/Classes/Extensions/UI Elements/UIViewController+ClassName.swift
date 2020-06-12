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
    
    class var className: String {
        return String(describing: self)
    }
    
}
