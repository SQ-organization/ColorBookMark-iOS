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
    private var signInViewController: SignInViewController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.signInViewController = SignInViewController()
    }
    
    func start() {
        self.signInViewController.viewModel = SignInViewModel(coordinator: self,
                                                              signInUseCase: DefaultSignInUseCase(repository: DefaultSignInRepository()))
        self.navigationController.viewControllers = [signInViewController]
    }
    
    func moveToHome() {
        
    }
    
    func pushEmailInputViewController() {
        let vc = SignInWithEmailViewController()
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    
}
