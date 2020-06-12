//
//  UIView+Nib.swift
//  commurnere-challenge
//
//  Created by Farshad Mousalou on 6/12/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UIView Object Generator from Nib file.
extension UIView {
    
    /// Unarchives the contents of a nib file located in the receiver's bundle owner class
    ///
    /// - Parameter nibNameOrNil: The name of the nib file, which need not include the .nib extension.
    /// - Returns: Returns: An `Self` View Object.
    class func fromNib(nibNameOrNil: String? = nil) -> Self {
        return fromNib(nibNameOrNil: nibNameOrNil, type: self)
    }
    
    /// Unarchives the contents of a nib file located in the receiver's bundle owner class.
    ///
    /// - Parameters:
    ///   - nibNameOrNil: The name of the nib file, which need not include the .nib extension.
    ///   - type: The Type Of `UIView` class, which need to create.
    /// - Returns: An `T` View Object.
    class func fromNib<T: UIView>(nibNameOrNil: String? = nil, type: T.Type) -> T {
        let view: T? = fromNib(nibNameOrNil: nibNameOrNil, type: T.self)
        return view!
    }
    
    /// Unarchives the contents of a nib file located in the receiver's bundle owner class.
    ///
    /// - Parameters:
    ///   - nibNameOrNil: The name of the nib file, which need not include the .nib extension.
    ///   - type: The Type Of `UIView` class, which need to create.
    /// - Returns: An `T` View Object.
    class func fromNib<T: UIView>(nibNameOrNil: String? = nil, type: T.Type) -> T? {
        var view: T?
        let name: String
        // assing nibName value, if provided.
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            // Most nibs are demangled by practice, if not, just declare string explicitly
            name = String(describing: T.self)
        }
        // instantiated the view from nib
        let nibViews = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        
        nibViews?.forEach({ (nibView) in
            // finding and casting the correct view
            if let tog = nibView as? T {
                view = tog
            }
        })
        
        return view
    }
    
}

// MARK: - UIView Nib Generator Extension.
extension UIView {
    
    /// Build a new `UINib` from current class type.
    ///
    /// - Parameter nibNameOrNil: The name of the nib file.
    /// - Returns: `UINib` object from the nib name passed into arguments.
    class func nib(nibNameOrNil: String? = nil) -> UINib {
        return nib(nibNameOrNil: nibNameOrNil, type: self)
    }
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - nibNameOrNil: The name of the nib file.
    ///   - type: The type of the class.
    /// - Returns: `UINib` object from the nib name passed into arguments.
    class func nib<T: UIView>(nibNameOrNil: String? = nil, type: T.Type) -> UINib {
        
        let name: String
        
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            // Most nibs are demangled by practice, if not, just declare string explicitly
            name = String(describing: type)
        }
        
        let bundle = Bundle(for: type)
        
        return UINib(nibName: name, bundle: bundle)
    }
}
