//
//  AddRecordViewModel.swift
//  ColorBookMarkV2
//
//  Created by SUN on 10/29/23.
//

import Foundation
import RxSwift

final class AddRecordViewModel {
    private let disposeBag = DisposeBag()
    private let selectedDate: Date
    
    init(selectedDate: Date) {
        self.selectedDate = selectedDate
    }
}
