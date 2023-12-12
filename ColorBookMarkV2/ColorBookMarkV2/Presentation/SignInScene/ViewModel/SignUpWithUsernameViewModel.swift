//
//  SignUpWithUsernameViewModel.swift
//  ColorBookMarkV2
//
//  Created by 김지훈 on 2023/06/11.
//

import UIKit
import RxSwift

final class SignUpWithUsernameViewModel {
    private let disposeBag = DisposeBag()
    private let coordinator: SignUpCoordinatorDependencies
    private let useCase: SignInUseCase
    private var usernameTextInput: String = ""
    
    init(coordinator: SignUpCoordinatorDependencies, signUpUseCase: SignInUseCase) {
        self.coordinator = coordinator
        self.useCase = signUpUseCase
    }
    
    struct Input {
        var usernameTextInput: Observable<String>
        var continueButtonTapped: Observable<Void>
    }
    
    struct Output {
        var usernameTextFieldOutput: PublishSubject<TextFieldState> = PublishSubject<TextFieldState>()
        var continueButtonIsValid: Observable<Bool>
    }
    
    func transform(from input: Input) -> Output {
        input.usernameTextInput
            .subscribe(onNext: { [weak self] in
                self?.usernameTextInput = $0
            })
            .disposed(by: disposeBag)
        
        let continuePublisher = input.usernameTextInput
            .map { $0.count > 0 && $0.count < 6 }
        
        input.continueButtonTapped
            .subscribe(onNext: { [weak self] _ in
                print("conTINUE")
            })
            .disposed(by: disposeBag)
        
        return Output(continueButtonIsValid: continuePublisher)
    }
}
