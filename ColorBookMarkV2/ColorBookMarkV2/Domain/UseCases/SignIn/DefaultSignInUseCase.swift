//
//  DefaultSignInUseCase.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/05/07.
//

import Foundation
import RxSwift

final class DefaultSignInUseCase: SignInUseCase {
    private let repository: SignInRepository
    var isRegistered = PublishSubject<Bool>()
    
    init(repository: SignInRepository) {
        self.repository = repository
    }
    
    func checkMemberWithKakao(key: String) {
        self.repository.checkMemberWithKakao(key: key)
    }
    
    func checkMemberWithApple(key: String) {
        self.repository.checkMemberWithApple(key: key)
    }
    
    
}
