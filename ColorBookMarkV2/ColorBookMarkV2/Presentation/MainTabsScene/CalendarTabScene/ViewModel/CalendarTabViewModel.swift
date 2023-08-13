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
        var changeMonth: Observable<Void>
        var didTapCalendarCell: Observable<Int>
        var didTapMonthButton: Observable<Void>
    }
    
    struct Output {
        var selectedMonthText = PublishSubject<String>()
        var selectedMonthInfo = BehaviorSubject<[String]>(value: [])
    }
    
    func transform(from input: Input) -> Output {
        let output = Output()
        
        input.didTapMonthButton
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.coordinator.presentMonthPickerViewController(with: self.useCase)})
            .disposed(by: disposeBag)
        
        self.useCase.selectedMonth
            .compactMap({ $0?.toString(format: "yyyy.MM") })
            .bind(to: output.selectedMonthText)
            .disposed(by: disposeBag)
        
        self.useCase.selectedMonth
            .compactMap { [weak self] selectedMonth in
                self?.getSelectedMonth(month: selectedMonth)
            }
            .bind(to: output.selectedMonthInfo)
            .disposed(by: disposeBag)
        
        return output
    }
}


extension CalendarTabViewModel {
    // 해당 월 날짜 가져오기
    func getSelectedMonth(month: Date?) -> [String] {
        guard let month = month else { return [] }

        let numOfDays = month.numberOfDaysInMonth
        let weekdayAdding = 2 - month.weekday
        var days: [String] = []
        for day in weekdayAdding...numOfDays {
            if day < 1 {
                days.append("")
            } else {
                days.append(String(day))
            }
        }
        return days
    }
}
