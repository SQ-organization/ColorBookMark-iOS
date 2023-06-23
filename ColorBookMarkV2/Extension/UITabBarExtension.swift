//
//  UITabBarExtension.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/06/23.
//

import UIKit

extension UITabBar {
    // tabbar 기본 그림자 초기화
    static func clearShadow() {
           UITabBar.appearance().shadowImage = UIImage()
           UITabBar.appearance().backgroundImage = UIImage()
           UITabBar.appearance().backgroundColor = UIColor.white
       }
}
