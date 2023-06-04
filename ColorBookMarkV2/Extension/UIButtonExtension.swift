//
//  UIButtonExtension.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/05/14.
//

import UIKit


extension UIButton {

        func moveImageLeftTextCenter(imagePadding: CGFloat = 30.0){
            guard let imageViewWidth = self.imageView?.frame.width else{return}
            guard let titleLabelWidth = self.titleLabel?.intrinsicContentSize.width else{return}
            self.contentHorizontalAlignment = .left
            imageEdgeInsets = UIEdgeInsets(top: 0.0, left: imagePadding - imageViewWidth / 2, bottom: 0.0, right: 0.0)
            titleEdgeInsets = UIEdgeInsets(top: 0.0, left: (bounds.width - titleLabelWidth) / 2 - imageViewWidth, bottom: 0.0, right: 0.0)
        }
    
}
