//
//  ExtensionManager.swift
//  chatApplication
//
//  Created by vivek shrivastwa on 30/05/22.
//

import Foundation
import UIKit

extension UIView {
    public var left: CGFloat {
        return self.frame.origin.x
    }
    
    public var top: CGFloat {
        return self.frame.origin.y
    }
    
    public var width: CGFloat {
        return self.frame.size.width
    }
    
    public var height: CGFloat {
        return self.frame.size.height
    }
    
    public var right: CGFloat {
        return left + width
    }
    
    public var bottom: CGFloat {
        return top + height
    }
    
}
