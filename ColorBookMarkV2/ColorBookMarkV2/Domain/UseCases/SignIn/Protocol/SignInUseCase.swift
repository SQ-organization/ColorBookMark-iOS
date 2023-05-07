//
//  SignInUseCase.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/04/23.
//

import Foundation
import RxSwift
protocol SignInUseCase {
    var isRegistered: PublishSubject<Bool> { get set }
    func checkMemberWithKakao(key: String)
    func checkMemberWithApple(key: String)
}
