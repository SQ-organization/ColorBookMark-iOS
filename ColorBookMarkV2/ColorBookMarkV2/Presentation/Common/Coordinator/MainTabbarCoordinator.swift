//
//  MainTabbarCoordinator.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/06/23.
//

import UIKit

final class MainTabbarCoordinator: MainTabbarCoordinatorDependencies {
    var tabBarController: BaseTaBarController
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.setNavigationBarHidden(true, animated: true)
        self.navigationController.isNavigationBarHidden = true
        self.tabBarController = BaseTaBarController()
    }
    
    func start() {
        let tabbars: [MainTabbar] = [.calendar, .record, .statistics, .setting]
        let controllers = tabbars.map({ createTabbarController(of: $0) })
        configureTabbarController(with: controllers)
    }
    func selectTab(_ tab: MainTabbar) {
        self.tabBarController.selectedIndex = tab.tabbarTag
    }
    
    func setSelectedIndex(_ index: Int) {
        guard let tab = MainTabbar(index: index) else { return }
        self.tabBarController.selectedIndex = tab.tabbarTag
    }
    
    func currentTab() -> MainTabbar? {
        MainTabbar(index: self.tabBarController.selectedIndex)
    }
    
    private func configureTabbarController(with controllers: [UIViewController]) {
        self.tabBarController.setViewControllers(controllers, animated: true)
        self.tabBarController.selectedIndex = MainTabbar.calendar.tabbarTag
//        UITabBar.clearShadow()
        self.tabBarController.tabBar.backgroundColor = .white
        self.tabBarController.tabBar.tintColor = .black
        self.navigationController.pushViewController(tabBarController, animated: true)
    }

    private func createTabbarController(of tabbar: MainTabbar) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = createTabbarItem(of: tabbar)
        startTabbarCoordinator(of: tabbar, to: navigationController)
        return navigationController
    }
    
    private func createTabbarItem(of tabbar: MainTabbar) -> UITabBarItem {
        let tabbarItem = UITabBarItem(title: tabbar.title, image: UIImage(named: tabbar.unselectedImageName), tag: tabbar.tabbarTag)
        tabbarItem.selectedImage = UIImage(named: tabbar.selectedImageName)
        return tabbarItem
    }
    
    private func startTabbarCoordinator(of tabbar: MainTabbar, to navigationController: UINavigationController) {
        switch tabbar {
        case .calendar:
            let calendarCoordinator = CaledarTabCoordinator(navigationController)
            self.childCoordinators = [calendarCoordinator]
            calendarCoordinator.start()
        case .record:
            let calendarCoordinator = CaledarTabCoordinator(navigationController)
            self.childCoordinators = [calendarCoordinator]
            calendarCoordinator.start()
        case .statistics:
            let calendarCoordinator = CaledarTabCoordinator(navigationController)
            self.childCoordinators = [calendarCoordinator]
            calendarCoordinator.start()
        case .setting:
            let settingCoordinator = SettingTabCoordinator(navigationController)
            self.childCoordinators = [settingCoordinator]
            settingCoordinator.start()
        }
    }
    
}
