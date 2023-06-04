//
//  SignInViewController.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/04/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SignInViewController: UIViewController {
    var viewModel: SignInViewModel?
    
    private var logoImageView: UIImageView = {
        let image = UIImage(named: "logoImage")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    private var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = StringConstant.letsStartColorBookMark
        label.textColor = .light_B02_Text
        label.textAlignment = .center
        return label
    }()
    private let stackView: UIStackView = UIStackView()
    private let signInKakaoButton: SignInButtonView = SignInButtonView(signInType: .kakao)
    private let signInAppleButton: SignInButtonView = SignInButtonView(signInType: .apple)
    private let signInEmailButton: SignInButtonView = SignInButtonView(signInType: .email)
    private let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "kakaoImage"), for: .normal)
        button.setTitle("gg", for: .normal)
        button.moveImageLeftTextCenter()
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bind()
    }
    
    private func setupLayout() {
        view.backgroundColor = .systemBackground
        stackView.axis = .vertical
        stackView.spacing = 12.0
        stackView.distribution = .equalSpacing
        [logoImageView,
         welcomeLabel,
         stackView]
            .forEach({ view.addSubview($0) })
        
        [signInKakaoButton,
         signInAppleButton,
         signInEmailButton,
         button]
            .forEach({ stackView.addArrangedSubview($0) })
        
        
        logoImageView.snp.makeConstraints({
            $0.width.equalTo(172.0)
            $0.height.equalTo(144.0)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(170.0)
            
        })
        
        welcomeLabel.snp.makeConstraints({
            $0.top.equalTo(logoImageView.snp.bottom).offset(24.0)
            $0.horizontalEdges.equalToSuperview()
        })
        
        stackView.snp.makeConstraints({
            $0.horizontalEdges.equalToSuperview().inset(16.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(24.0)
        })
        
        signInEmailButton.snp.makeConstraints({
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48.0)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(24.0)
        })
//
        signInAppleButton.snp.makeConstraints({
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48.0)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(24.0)
        })

        signInKakaoButton.snp.makeConstraints({
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48.0)
        })
        
        button.snp.makeConstraints({
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48.0)
        })
//
        
    }
    
    // MARK: viewModel bind
    private func bind() {
//        let input = SignInViewModel
//            .Input(kakaoSignInButtonTapped: signInKakaoButton.rx.tapG,
//                   appleSignInButtonTapped: signInAppleButton.gesture(.tap()),
//                   emailSignInButtonTapped: signInEmailButton.gesture(.tap()))
//        let output = viewModel?.transform(from: input)
        
    }
}
