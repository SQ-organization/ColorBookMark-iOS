//
//  SignInCoordinator.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/05/07.
//

import Foundation
import UIKit

final class SignInCoordinator: SignInCoordinatorDependencies {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
    
    func moveToHome() {
        
    }
    
    func pushEmailInputViewController() {
        
    }
    
    
}
