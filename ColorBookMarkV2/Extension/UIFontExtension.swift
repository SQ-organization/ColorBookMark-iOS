//
//  UIFontExtension.swift
//  ColorBookMarkV2
//
//  Created by 김지훈 on 2023/05/22.
//

import UIKit

extension UIFont {
    public enum PretendardType: String {
        case bold = "Bold"
        case medium = "Medium"
    }
    
    static func Pretendard(_ type: PretendardType, size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-\(type.rawValue)", size: size)!
    }
}
