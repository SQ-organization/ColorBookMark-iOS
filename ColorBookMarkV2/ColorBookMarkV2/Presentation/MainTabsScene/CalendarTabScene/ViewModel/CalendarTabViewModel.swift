//
//  CalendarTabViewModel.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/07/21.
//

import Foundation
import RxSwift

final class CalendarTabViewModel {
    private let disposeBag = DisposeBag()
    private let coordinator: CalendarTabCoordinatorDependencies
    private let useCase: CalendarTabUseCase
    
    init(coordinator: CalendarTabCoordinatorDependencies, calendarTabUseCase: CalendarTabUseCase) {
        self.coordinator = coordinator
        self.useCase = calendarTabUseCase
    }
    
    struct Input {
        var didTapCalendarCell: Observable<Void>
        var changeMonth: Observable<Void>
    }
    
    struct Output {
        var selectedMonthText: PublishSubject<String>
    }
}
