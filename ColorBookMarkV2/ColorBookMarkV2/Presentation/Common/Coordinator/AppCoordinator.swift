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
    // 테스트용 플래그.
    private var isSignUp: Bool = false
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if isSignUp {
            startMainFlow()
        } else {
            startSignInFlow()
        }
    }
    
    func startSignInFlow() {
        let coordinator = SignInCoordinator(navigationController)
        coordinator.start()
    }
    
    func startMainFlow() {
        let coordinator = MainTabbarCoordinator(navigationController)
        coordinator.start()
    }
    
    
}
