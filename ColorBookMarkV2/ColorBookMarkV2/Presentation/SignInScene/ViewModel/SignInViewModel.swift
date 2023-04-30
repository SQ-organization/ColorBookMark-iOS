//
//  SignInViewModel.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/04/23.
//

import Foundation
import RxSwift

final class SignInViewModel {
    
    struct Input {
        var kakaoSignInButtonTapped: Observable<Void>
        var appleSignInButtonTapped: Observable<Void>
        var emailSignInButtonTapped: Observable<Void>
        
        // email text 입력 완료 버튼 탭
        // 계속하기 버튼 탭
        // 비밀번호 입력 후 들어가가 탭 추가
    }
    
    struct Output {
        
    }
}
