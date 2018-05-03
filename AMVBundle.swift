//
//  AMVBundle.swift
//  AMVEditableMediaView
//
//  Created by admin on 3/5/18.
//

import Foundation

@objc open class AMVBundle: NSObject {
    open class func getBundle() -> Bundle? {
        return Bundle(for: AMVBundle.self)
    }
}
