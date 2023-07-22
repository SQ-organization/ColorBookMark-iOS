//
//  CalendarTabUseCase.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/07/21.
//

import Foundation
import RxSwift

protocol CalendarTabUseCase {
    var selectedMonth: BehaviorSubject<Date> { get set }
}
