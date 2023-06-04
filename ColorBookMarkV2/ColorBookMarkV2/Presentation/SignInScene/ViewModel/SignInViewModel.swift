//
//  SignInViewModel.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/04/23.
//

import UIKit
import RxSwift

final class SignInViewModel {
    private let disposeBag = DisposeBag()
    private let coordinator: SignInCoordinatorDependencies
    private let useCase: SignInUseCase
    private var textFieldInput: String = ""
    
    init(coordinator: SignInCoordinatorDependencies, signInUseCase: SignInUseCase) {
        self.coordinator = coordinator
        self.useCase = signInUseCase
    }
    
    struct Input {
        var kakaoSignInButtonTapped: Observable<Void>
        var appleSignInButtonTapped: Observable<Void>
        var emailSignInButtonTapped: Observable<Void>
        var textFieldInput: Observable<String>
        var textFieldInputText: String = ""
        
        // email text 입력 완료 버튼 탭
        // 계속하기 버튼 탭
        // 비밀번호 입력 후 들어가가 탭 추가
    }
    
    // 로그인 화면으로 방출하는 데이터는 없으므로 일단 output 빈값 유지
    struct Output {
        var textFieldOutput: PublishSubject<TextFieldState> = PublishSubject<TextFieldState>()
    }
    
    func transform(from input: Input) -> Output {
        let output = Output()
        
        input.kakaoSignInButtonTapped
            .subscribe(onNext: { [weak self] _ in
                self?.coordinator.pushEmailInputViewController()
            })
            .disposed(by: disposeBag)
        
        input.textFieldInput
            .subscribe(onNext: { [weak self] in
                self?.textFieldInput = $0
            })
            .disposed(by: disposeBag)
        
        input.appleSignInButtonTapped
            .subscribe (onNext: {  [weak self] in
                if self?.textFieldInput.count ?? 0 > 5 {
                    output.textFieldOutput.onNext(.done(message: ""))
                } else {
                    output.textFieldOutput.onNext(.error(message: "15자"))
                }
            })
            .disposed(by: disposeBag)
        
        return output
    }
}
