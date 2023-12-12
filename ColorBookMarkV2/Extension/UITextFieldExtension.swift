//
//  UITextFieldExtension.swift
//  Release
//
//  Created by 김지훈 on 2023/05/25.
//

import UIKit

extension UITextField {
    func setUnderline(color: UIColor) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.size.height-4, width: self.frame.width, height: 4)
        border.backgroundColor = color.cgColor
        border.cornerRadius = 5
        border.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.layer.addSublayer((border))
        self.textAlignment = .center
    }
}
