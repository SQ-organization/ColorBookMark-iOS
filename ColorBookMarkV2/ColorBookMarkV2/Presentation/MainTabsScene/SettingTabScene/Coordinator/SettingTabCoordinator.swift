//
//  SettingTabCoordinator.swift
//  ColorBookMarkV2
//
//  Created by SUN on 11/26/23.
//

import Foundation
import UIKit

final class SettingTabCoordinator: SettingTabCoordinatorDependencies {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator]
    var setttingTabViewController: SettingTabViewController
    
    init(_ navigationController: UINavigationController, childCoordinators: [Coordinator] = []) {
        self.navigationController = navigationController
        self.childCoordinators = childCoordinators
        self.setttingTabViewController = SettingTabViewController()
    }
    
    func start() {
        navigationController.pushViewController(setttingTabViewController, animated: true)
    }
    
    
}
