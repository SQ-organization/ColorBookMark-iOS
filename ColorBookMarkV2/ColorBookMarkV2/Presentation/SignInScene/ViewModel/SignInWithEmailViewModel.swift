//
//  SignInWithEmailViewModel.swift
//  ColorBookMarkV2
//
//  Created by 김지훈 on 2023/05/21.
//

import Combine
import UIKit

final class SignInWithEmailViewModel {
    private var cancellables = Set<AnyCancellable>()
    private let coordinator: SignInCoordinatorDependencies
    private let useCase: SignInUseCase
    
    let emailCheckList = ["@", ".com"]
    
    init(coordinator: SignInCoordinatorDependencies, signInUseCase: SignInUseCase) {
        self.coordinator = coordinator
        self.useCase = signInUseCase
    }
    
    struct Input {
        var emailTextInput: AnyPublisher<String?, Never>
        var continueButtonTapped: AnyPublisher<Void, Never>
    }
    
    struct Output {
        var emailTextInvalid: AnyPublisher<Bool, Never>
        var continueButtonIsValid: AnyPublisher<Bool, Never>
    }
    
    func transform(from input: Input) -> Output {
        input.continueButtonTapped
            .sink(receiveValue: { [weak self] _ in
                // move to passwordViewController
                // signupScene
            })
            .store(in: &cancellables)
        
        let emailTextStatePublisher = input.emailTextInput
            .compactMap { $0 }
            .map { [self] in $0.count > 0 && !emailCheckList.allSatisfy($0.contains)}
            .eraseToAnyPublisher()
        
        let buttonStatePublisher = input.emailTextInput
            .compactMap { $0 }
            .map { [self] in emailCheckList.allSatisfy($0.contains)}
            .eraseToAnyPublisher()
        
        return Output(emailTextInvalid: emailTextStatePublisher, continueButtonIsValid: buttonStatePublisher)
    }
}
