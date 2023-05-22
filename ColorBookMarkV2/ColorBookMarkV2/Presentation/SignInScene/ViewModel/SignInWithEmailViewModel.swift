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
    
    init(coordinator: SignInCoordinatorDependencies, signInUseCase: SignInUseCase) {
        self.coordinator = coordinator
        self.useCase = signInUseCase
    }
    
    struct Input {
        var emailTextInput: AnyPublisher<String?, Never>
        var continueButtonTapped: AnyPublisher<GestureType, Never>
    }
    
    struct Output {
        var continueButtonIsValid: AnyPublisher<Bool, Never>
    }
    
    func transform(from input: Input) -> Output {
        input.continueButtonTapped
            .sink(receiveValue: { [weak self] _ in
                // move to passwordViewController
            })
            .store(in: &cancellables)
        
        let buttonStatePublisher = input.emailTextInput
            .compactMap { $0 }
            .map { $0.count > 0 && $0.contains("@")}
            .eraseToAnyPublisher()
        
        return Output(continueButtonIsValid: buttonStatePublisher)
    }
}
