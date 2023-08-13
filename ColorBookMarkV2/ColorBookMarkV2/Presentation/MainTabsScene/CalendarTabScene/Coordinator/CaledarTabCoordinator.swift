//
//  CaledarTabCoordinator.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/06/23.
//

import UIKit

final class CaledarTabCoordinator: CalendarTabCoordinatorDependencies {
    var navigationController: UINavigationController
    var caledarTabViewController: CaledarTabViewController
    var childCoordinators: [Coordinator] = []
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.caledarTabViewController = CaledarTabViewController()
    }
    
    func start() {
        self.caledarTabViewController.viewModel = CalendarTabViewModel(coordinator: self,
                                                                       calendarTabUseCase: DefaultCalendarTabUseCase())
        self.navigationController.pushViewController(caledarTabViewController, animated: true)
    }
    
    func presentMonthPickerViewController(with useCase: CalendarTabUseCase) {
        let vc = MonthPickerViewController(delegate: useCase)
        self.navigationController.present(vc, animated: true)
    }

}
