//
//  UIImage.swift
//  ScrollViewWithImages
//
//  Created by Niharika Sharma on 2017-05-25.
//  Copyright © 2017 Sophie. All rights reserved.
//

import UIKit

extension UIImage {
    class func imageWithView(view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isHidden, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}
