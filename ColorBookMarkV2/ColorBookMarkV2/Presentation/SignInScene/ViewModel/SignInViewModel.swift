//
//  SignInViewModel.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/04/23.
//

import Combine

final class SignInViewModel {
    private var cancellables = Set<AnyCancellable>()
    private let coordinator: SignInCoordinatorDependencies
    private let useCase: SignInUseCase
    
    init(coordinator: SignInCoordinatorDependencies, signInUseCase: SignInUseCase) {
        self.coordinator = coordinator
        self.useCase = signInUseCase
    }
    
    struct Input {
        var kakaoSignInButtonTapped: AnyPublisher<Void, Never>
        var appleSignInButtonTapped: AnyPublisher<Void, Never>
        var emailSignInButtonTapped: AnyPublisher<Void, Never>
        
        // email text 입력 완료 버튼 탭
        // 계속하기 버튼 탭
        // 비밀번호 입력 후 들어가가 탭 추가
    }
    
    // 로그인 화면으로 방출하는 데이터는 없으므로 일단 output 빈값 유지
    struct Output {
        
    }
    
    func transform(from input: Input) -> Output {
        let output = Output()
        
        input.kakaoSignInButtonTapped
            .sink(receiveValue: { [weak self] _ in
                self?.coordinator.pushEmailInputViewController()
            })
            .store(in: &cancellables)
        
        return output
    }
}
