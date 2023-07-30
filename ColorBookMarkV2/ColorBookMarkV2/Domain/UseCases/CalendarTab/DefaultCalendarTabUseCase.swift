//
//  DefaultCalendarTabUseCase.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/07/22.
//

import Foundation
import RxSwift

final class DefaultCalendarTabUseCase: CalendarTabUseCase {
    var selectedMonth: BehaviorSubject<Date?> = BehaviorSubject(value: Date().startOfMonth)
    
}
