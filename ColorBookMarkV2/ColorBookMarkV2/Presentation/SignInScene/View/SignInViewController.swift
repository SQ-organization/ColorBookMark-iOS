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
    private let signInKakaoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .yellow
        button.setTitle("카카오", for: .normal)
        button.setImage(UIImage(named: "kakaoImage"), for: .normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        [signInKakaoButton]
            .forEach({ view.addSubview($0) })
        signInKakaoButton.snp.makeConstraints({
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(50.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20.0)
        })
    }
    
    // MARK: viewModel bind
    private func bind() {
        let input = SignInViewModel
            .Input(kakaoSignInButtonTapped: signInKakaoButton.rx.tap.asObservable(),
                   appleSignInButtonTapped: signInKakaoButton.rx.tap.asObservable(),
                   emailSignInButtonTapped: signInKakaoButton.rx.tap.asObservable())
    }
}
