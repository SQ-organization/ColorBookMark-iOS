//
//  MainTabbarCoordinatorDependencies.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/06/23.
//

import UIKit

protocol MainTabbarCoordinatorDependencies: Coordinator {
    var tabBarController: UITabBarController { get set }
    func selectTab(_ tab: MainTabbar)
    func setSelectedIndex(_ index: Int)
    func currentTab() -> MainTabbar?
}
