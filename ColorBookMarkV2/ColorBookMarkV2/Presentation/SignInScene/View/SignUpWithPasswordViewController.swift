//
//  SignUpWithPasswordViewController.swift
//  ColorBookMarkV2
//
//  Created by 김지훈 on 2023/06/05.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SignUpWithPasswordViewController: UIViewController {
    private var disposeBag = DisposeBag()
    var viewModel: SignUpWithPasswordViewModel?
    
    private var signUpTitleLabel: UILabel = {
        let label = UILabel()
        label.text = StringConstant.startSignUp
        label.font = .Pretendard(.medium, size: 16)
        label.textColor = .txt_secondary
        label.textAlignment = .center
        return label
    }()
    
    private var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrowBack"), for: .normal)
        return button
    }()
    
    private var logoImageView: UIImageView = {
        let image = UIImage(named: "logoImage")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    private var enterPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = StringConstant.enterPassword
        label.font = .Pretendard(.bold, size: 24)
        label.textColor = .txt_secondary
        label.textAlignment = .center
        return label
    }()
    
    private var greetingLabel: UILabel = {
        let label = UILabel()
        label.text = StringConstant.greeting
        label.font = .Pretendard(.medium, size: 16)
        label.textColor = .txt_secondary
        label.textAlignment = .center
        return label
    }()
    
    private var passwordTextfield: CustomTextField = {
        let textField = CustomTextField()
        textField.setReturnKey(.done)
        textField.setPlaceHolder(StringConstant.passwordPlaceholder_1)
        textField.setSecureMode(true)
        return textField
    }()
    
    private var passwordVerifyTextfield: CustomTextField = {
        let textField = CustomTextField()
        textField.setReturnKey(.done)
        textField.setPlaceHolder(StringConstant.passwordPlaceholder_2)
        textField.setSecureMode(true)
        return textField
    }()
    
    private var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle(StringConstant.continueText, for: .normal)
        button.titleLabel?.font = .Pretendard(.bold, size: 16)
        button.setTitleColor(.txt_disabled, for: .normal)
        button.backgroundColor = .component_disabled
        button.layer.cornerRadius = 22.5
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bind()
    }
    
    private func setupLayout() {
        view.backgroundColor = .systemBackground
        
        [signUpTitleLabel,
         backButton,
         logoImageView,
         enterPasswordLabel,
         greetingLabel,
         passwordTextfield,
         passwordVerifyTextfield,
         continueButton]
            .forEach({ view.addSubview($0) })
        
        signUpTitleLabel.snp.makeConstraints({
            $0.top.equalToSuperview().inset(72.0)
            $0.horizontalEdges.equalToSuperview()
        })
        
        backButton.snp.makeConstraints({
            $0.centerY.equalTo(signUpTitleLabel.snp.centerY)
            $0.left.equalToSuperview().inset(24.0)
            $0.width.height.equalTo(44.0)
        })
        
        logoImageView.snp.makeConstraints({
            $0.top.equalTo(signUpTitleLabel.snp.bottom).offset(13.9)
            $0.width.equalTo(120.0)
            $0.height.equalTo(96.4)
            $0.centerX.equalToSuperview()
        })
        
        enterPasswordLabel.snp.makeConstraints({
            $0.top.equalTo(logoImageView.snp.bottom).offset(9.6)
            $0.horizontalEdges.equalToSuperview()
        })
        
        greetingLabel.snp.makeConstraints({
            $0.top.equalTo(enterPasswordLabel.snp.bottom).offset(7.0)
            $0.horizontalEdges.equalToSuperview()
        })
        
        passwordTextfield.snp.makeConstraints({
            $0.top.equalTo(greetingLabel.snp.bottom).offset(23.0)
            $0.horizontalEdges.equalToSuperview().inset(24.0)
        })
        
        passwordVerifyTextfield.snp.makeConstraints({
            $0.top.equalTo(passwordTextfield.snp.bottom).offset(20.0)
            $0.horizontalEdges.equalToSuperview().inset(24.0)
        })
        
        continueButton.snp.makeConstraints({
            $0.top.equalTo(passwordVerifyTextfield.snp.bottom).offset(40.0)
            $0.width.equalTo(380.0)
            $0.height.equalTo(45.0)
            $0.centerX.equalToSuperview()
        })
    }
    
    private func bind() {
        let input = SignUpWithPasswordViewModel.Input(passwordTextInput: passwordTextfield.textPublisher(), passwordVerifyTextInput: passwordVerifyTextfield.textPublisher(), continueButtonTapped: continueButton.rx.tap.asObservable())
        let output = viewModel?.transform(from: input)
        
        // 계속하기 버튼 활성화
        output?
            .continueButtonIsValid
            .subscribe(onNext: { state in
                self.enableContinueButton(state: state)
            }).disposed(by: disposeBag)
        
        // 비밀번호 확인 텍스트필드 활성화
        output?
            .passwordTextFieldIsValid
            .subscribe(onNext: { state in
                self.passwordVerifyTextfield.enableTextfieldUserInteraction(state)
            }).disposed(by: disposeBag)
        
        output?.passwordTextFieldOutput
            .subscribe(onNext: { [weak self] in
                self?.passwordTextfield.textFieldStateSubject.onNext($0)
            })
            .disposed(by: disposeBag)
        
        output?.passwordVerifyTextFieldOutput
            .subscribe(onNext: { [weak self] in
                self?.passwordVerifyTextfield.textFieldStateSubject.onNext($0)
            })
            .disposed(by: disposeBag)
        
        //MARK: bind / transform
        output?.passwordTextFieldIsValid
            .subscribe(onNext: { valid in
                if valid {
                    output?.passwordTextFieldOutput.onNext(.done(message: StringConstant.passwordDone))
                }
                else {
                    output?.passwordTextFieldOutput.onNext(.done(message: " "))
                }
            })
            .disposed(by: disposeBag)
        
        output?.continueButtonIsValid
            .subscribe (onNext: { valid in
                if valid {
                    output?.passwordVerifyTextFieldOutput.onNext(.done(message: StringConstant.passwordVerifyDone))
                }
                else {
                    output?.passwordVerifyTextFieldOutput.onNext(.error(message: StringConstant.passwordError))
                }
            })
            .disposed(by: disposeBag)
    }
    
    func enableContinueButton(state: Bool) {
        continueButton.isEnabled = state
        continueButton.setTitleColor(state ? .txt_component : .txt_disabled, for: .normal)
        continueButton.backgroundColor = state ? .component_primary : .component_disabled
    }
}
