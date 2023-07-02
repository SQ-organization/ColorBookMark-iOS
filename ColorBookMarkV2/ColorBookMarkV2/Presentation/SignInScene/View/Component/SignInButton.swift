//
//  LoginButtonView.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/05/19.
//

import UIKit
import SnapKit

final class SignInButton: UIButton {
    private var signInType: SignInType

    init(signInType: SignInType) {
        self.signInType = signInType
        super.init(frame: .zero)
        setupUI()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.backgroundColor = signInType.backgroundColor
        if signInType == .apple {
            self.layer.borderColor = UIColor.white.cgColor
            self.layer.borderWidth = 1.0
        }
        self.layer.cornerRadius = 5.0
        self.setImage(signInType.image, for: .normal)
        self.setTitle(signInType.title, for: .normal)
        self.setTitleColor(signInType.textColor, for: .normal)
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.font = .systemFont(ofSize: 17.0, weight: .medium)
        let length = self.titleLabel?.frame.width
        let lengthToMove = (UIScreen.main.bounds.width - (length ?? 0.0)) / 2.0 - 10.0
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -lengthToMove, bottom: 0, right: 0)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 44)
    }
}

enum SignInType {
    case kakao
    case apple
    case email
    
    var textColor: UIColor? {
        switch self {
        case .kakao, .apple:
            return .txt_primary
        case .email:
            return .white
        }
    }
    
    var backgroundColor: UIColor? {
        switch self {
        case .kakao:
            return .kakaoBackground
        case .apple:
            return .appleBackground
        case .email:
            return .emailBackground
        }
    }
    
    var title: String {
        switch self {
        case .kakao:
            return StringConstant.signInWithKakao
        case .apple:
            return StringConstant.signInWithApple
        case .email:
            return StringConstant.signInWithEmail
        }
    }
    
    var image: UIImage? {
        switch self {
        case .kakao:
            return UIImage(named: "kakaoImage")
        case .apple:
            return UIImage(named: "appleImage")
        case .email:
            return UIImage(named: "emailImage")
        }
    }
}
