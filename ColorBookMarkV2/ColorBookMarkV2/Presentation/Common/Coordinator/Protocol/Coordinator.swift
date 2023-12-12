//
//  Coordinator.swift
//  Release
//
//  Created by SUN on 2023/04/30.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    func start()
}


