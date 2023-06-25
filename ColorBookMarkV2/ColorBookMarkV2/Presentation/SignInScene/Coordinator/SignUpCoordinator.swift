//
//  SignUpCoordinator.swift
//  ColorBookMarkV2
//
//  Created by 김지훈 on 2023/06/05.
//

import Foundation
import UIKit

final class SignUpCoordinator: SignUpCoordinatorDependencies {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    private var signUpWithPasswordViewController: SignUpWithPasswordViewController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.signUpWithPasswordViewController = SignUpWithPasswordViewController()
    }
    
    func start() {
        self.signUpWithPasswordViewController.viewModel = SignUpWithPasswordViewModel(coordinator: self, signUpUseCase: DefaultSignInUseCase(repository: DefaultSignInRepository()))
        self.navigationController.viewControllers = [signUpWithPasswordViewController]
    }
}
