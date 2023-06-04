//
//  SignInWithEmailViewModel.swift
//  ColorBookMarkV2
//
//  Created by 김지훈 on 2023/05/21.
//

import UIKit
import RxSwift
import RxCocoa

final class SignInWithEmailViewModel {
    private var disposeBag = DisposeBag()
    private let coordinator: SignInCoordinatorDependencies
    private let useCase: SignInUseCase
    private var emailTextInput: String = ""
    
    init(coordinator: SignInCoordinatorDependencies, signInUseCase: SignInUseCase) {
        self.coordinator = coordinator
        self.useCase = signInUseCase
    }
    
    struct Input {
        var emailTextInput: Observable<String>
        var continueButtonTapped: Observable<Void>
    }
    
    struct Output {
        var emailTextFieldOutput: PublishSubject<TextFieldState> = PublishSubject<TextFieldState>()
        var emailTextValid: Observable<Bool>
        var continueButtonIsValid: Observable<Bool>
    }
    
    func transform(from input: Input) -> Output {
        let emailValidState = input.emailTextInput
            .compactMap { $0 }
            .map { [self] in isValidEmail(emailText: $0)}
        
        let emailTextStatePublisher = input.continueButtonTapped.withLatestFrom(emailValidState)
        
        input.emailTextInput
            .subscribe(onNext: { [weak self] in
                self?.emailTextInput = $0
            })
            .disposed(by: disposeBag)
        
        let buttonStatePublisher = input.emailTextInput
            .compactMap { $0 }
            .map { $0.count > 0}
        
        let output = Output(emailTextValid: emailTextStatePublisher, continueButtonIsValid: buttonStatePublisher)
        
        input.continueButtonTapped
            .subscribe (onNext: {  [self] in
                if isValidEmail(emailText: emailTextInput) {
                    output.emailTextFieldOutput.onNext(.done(message: " "))
                }
                else {
                    output.emailTextFieldOutput.onNext(.error(message: "올바른 이메일 형식으로  입력해주세요!"))
                }
            })
            .disposed(by: disposeBag)
        
        return output
    }
    
    func isValidEmail(emailText:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailText)
    }
}
