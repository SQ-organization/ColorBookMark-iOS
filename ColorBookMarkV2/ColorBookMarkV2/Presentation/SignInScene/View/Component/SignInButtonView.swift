//
//  LoginButtonView.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/05/19.
//

import UIKit
import SnapKit

final class SignInButtonView: UIView {
    private var signInType: SignInType
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: signInType.image)
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = signInType.title
        label.font = .systemFont(ofSize: 17.0, weight: .medium)
        label.textColor = signInType.textColor
        label.textAlignment = .center
        return label
    }()

    init(signInType: SignInType) {
        self.signInType = signInType
        super.init(frame: .zero)
        setupUI()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        [imageView,
        titleLabel]
            .forEach({self.addSubview($0)})
        self.contentMode = .center
        self.backgroundColor = signInType.backgroundColor
        if signInType == .apple {
            self.layer.borderColor = UIColor.light_B03?.cgColor
            self.layer.borderWidth = 1.0
        }
        self.layer.cornerRadius = 5.0
        imageView.snp.makeConstraints({
            $0.height.equalTo(37.0)
            $0.width.equalTo(imageView.snp.height)
            $0.leading.equalToSuperview().inset(10.0)
            $0.centerY.equalToSuperview()
        })

        titleLabel.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
}

enum SignInType {
    case kakao
    case apple
    case email
    
    var textColor: UIColor? {
        switch self {
        case .kakao, .apple:
            return .light_B02_Text
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
