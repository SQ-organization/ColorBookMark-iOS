//
//  SignUpWithPasswordViewModel.swift
//  ColorBookMarkV2
//
//  Created by 김지훈 on 2023/06/05.
//

import UIKit
import RxSwift

final class SignUpWithPasswordViewModel {
    private let disposeBag = DisposeBag()
    private let coordinator: SignUpCoordinatorDependencies
    private let useCase: SignInUseCase
    
    init(coordinator: SignUpCoordinatorDependencies, signUpUseCase: SignInUseCase) {
        self.coordinator = coordinator
        self.useCase = signUpUseCase
    }
    
    struct Input {
        var passwordTextInput: Observable<String>
        var passwordVerifyTextInput: Observable<String>
        var continueButtonTapped: Observable<Void>
    }
    
    struct Output {
        var passwordTextFieldOutput: PublishSubject<TextFieldState> = PublishSubject<TextFieldState>()
        var passwordVerifyTextFieldOutput: PublishSubject<TextFieldState> = PublishSubject<TextFieldState>()
        var passwordTextFieldIsValid: Observable<Bool>
        var continueButtonIsValid: Observable<Bool>
    }
    
    func transform(from input: Input) -> Output {
        let passwordVerifyStatePublisher = input.passwordTextInput
            .map { $0.count > 5}
        
        let continuePublisher = Observable.combineLatest(input.passwordTextInput, input.passwordVerifyTextInput)
            .filter { !$0.0.isEmpty}
            .filter { !$0.1.isEmpty}
            .map {
                if ($0 == $1) { return true }
                return false
            }
        
        //pushUsernameInputViewController
        input.continueButtonTapped
            .subscribe(onNext: { [weak self] _ in
                self?.coordinator.pushUsernameInputViewController()
            })
            .disposed(by: disposeBag)
        
        return Output(passwordTextFieldIsValid: passwordVerifyStatePublisher, continueButtonIsValid: continuePublisher)
    }
}
