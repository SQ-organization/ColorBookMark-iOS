//
//  SignInRepository.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/05/07.
//

import Foundation

protocol SignInRepository {
    func checkMemberWithKakao(key: String)
    func checkMemberWithApple(key: String)
}
