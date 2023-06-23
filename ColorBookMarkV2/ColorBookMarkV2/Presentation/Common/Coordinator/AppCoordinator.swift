//
//  AppCoordinator.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/05/14.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let coordinator = MainTabbarCoordinator(navigationController)
        coordinator.start()
    }
    
    
}
