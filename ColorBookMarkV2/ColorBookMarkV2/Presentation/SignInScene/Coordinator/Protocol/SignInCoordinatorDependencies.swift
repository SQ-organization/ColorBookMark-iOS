//
//  SignInCoordinatorDependencies.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/05/07.
//

import Foundation

protocol SignInCoordinatorDependencies: Coordinator {
    func moveToHome()
    func pushEmailInputViewController()
    func showPopup()
}
