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
    private var signInWithEmailViewController: SignInWithEmailViewController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.signInViewController = SignInViewController()
        self.signInWithEmailViewController = SignInWithEmailViewController()
    }
    
    func start() {
        self.signInViewController.viewModel = SignInViewModel(coordinator: self, signInUseCase: DefaultSignInUseCase(repository: DefaultSignInRepository()))
        self.navigationController.viewControllers = [signInViewController]
    }
    
    func moveToHome() {
        print("BACK")
        self.navigationController.popViewController(animated: true)
    }
    
    func pushEmailInputViewController() {
        self.signInWithEmailViewController.viewModel = SignInWithEmailViewModel(coordinator: self, signInUseCase: DefaultSignInUseCase(repository: DefaultSignInRepository()))
        self.navigationController.viewControllers = [signInWithEmailViewController]
    }
    
    func showPopup() {
        self.navigationController.showPopUp(title: "야야", subTitleInfo: "dididfdsfadsf", leftButtonText: "ggg", rightButtonText: "야야", rightButtonTapped: { print("gg")})
    }
        
    func moveToSignUpScene() {
        let coordinator = SignUpCoordinator(navigationController)
        coordinator.start()
    }
}
