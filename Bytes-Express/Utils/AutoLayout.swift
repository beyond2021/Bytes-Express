//
//  AutoLayout.swift
//  Bytes-Express
//
//  Created by Kev1 on 11/25/18.
//  Copyright © 2018 Kev1. All rights reserved.
//

import Cocoa
extension NSView{
    
    // Apply clipping mask on certain corners with corner radius
//    func layoutCornerRadiusMask(corners: UIRectCorner, cornerRadius: CGFloat) {
//        let cornerRadii = CGSize(width: cornerRadius, height: cornerRadius)
//        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: cornerRadii)
//        
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        
//        layer.mask = mask
//    }
//    
//    // Apply corner radius and rounded shadow path
//    func layoutCornerRadiusAndShadow(cornerRadius: CGFloat) {
//        // Apply corner radius for background fill only
//        layer.cornerRadius = cornerRadius
//        
//        // Apply shadow with rounded path
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.15
//        layer.shadowRadius = 2.0
//        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
//    }
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width : CGFloat, height: CGFloat ){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
            
        }
        
        //        self.topAnchor.constraint(equalTo: top!, constant: paddingTop).isActive = true
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
            
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
            
        }
        
}
}
