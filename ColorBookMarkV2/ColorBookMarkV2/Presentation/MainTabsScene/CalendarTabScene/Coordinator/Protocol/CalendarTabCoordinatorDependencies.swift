//
//  CalendarTabCoordinatorDependencies.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/06/23.
//

import Foundation

protocol CalendarTabCoordinatorDependencies: Coordinator {
    func start()
    func presentMonthPickerViewController(with useCase: CalendarTabUseCase)
}
