//
//  SignInWithEmailViewModel.swift
//  ColorBookMarkV2
//
//  Created by 김지훈 on 2023/05/21.
//

import UIKit
import RxSwift

final class SignInWithEmailViewModel {
    private var disposeBag = DisposeBag()
    private let coordinator: SignInCoordinatorDependencies
    private let useCase: SignInUseCase
    
    let emailCheckList = ["@", ".com"]
    
    init(coordinator: SignInCoordinatorDependencies, signInUseCase: SignInUseCase) {
        self.coordinator = coordinator
        self.useCase = signInUseCase
    }
    
    struct Input {
        var emailTextInput: Observable<String?>
        var continueButtonTapped: Observable<Void>
    }
    
    struct Output {
        var emailTextInvalid: Observable<Bool>
        var continueButtonIsValid: Observable<Bool>
    }
    
    func transform(from input: Input) -> Output {
        input.continueButtonTapped
            .subscribe(onNext: { [weak self] _ in
                // move to passwordViewController
                // signupScene
            })
            .disposed(by: disposeBag)
        
        let emailTextStatePublisher = input.emailTextInput
            .compactMap { $0 }
            .map { [self] in $0.count > 0 && !emailCheckList.allSatisfy($0.contains)}
            .asObservable()
        
        let buttonStatePublisher = input.emailTextInput
            .compactMap { $0 }
            .map { [self] in emailCheckList.allSatisfy($0.contains)}
            .asObservable()
        
        return Output(emailTextInvalid: emailTextStatePublisher, continueButtonIsValid: buttonStatePublisher)
    }
}
