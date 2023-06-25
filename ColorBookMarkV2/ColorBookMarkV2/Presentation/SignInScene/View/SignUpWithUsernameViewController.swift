//
//  SignUpWithUsernameViewController.swift
//  ColorBookMarkV2
//
//  Created by 김지훈 on 2023/06/11.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SignUpWithUsernameViewController: UIViewController {
    private var disposeBag = DisposeBag()
    var viewModel: SignUpWithUsernameViewModel?
    
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
    
    private var enterUsernameLabel: UILabel = {
        let label = UILabel()
        label.text = StringConstant.enterUsername
        label.font = .Pretendard(.bold, size: 24)
        label.textColor = .txt_secondary
        label.textAlignment = .center
        return label
    }()
    
    private var finalLabel: UILabel = {
        let label = UILabel()
        label.text = StringConstant.final
        label.font = .Pretendard(.medium, size: 16)
        label.textColor = .txt_secondary
        label.textAlignment = .center
        return label
    }()
    
    private var usernameTextfield: CustomTextField = {
        let textField = CustomTextField()
        textField.setReturnKey(.done)
        textField.setPlaceHolder(StringConstant.usernamePlaceholder)
        return textField
    }()
    
    private var usernameNoticeLabel: UILabel = {
        let label = UILabel()
        label.text = StringConstant.usernameNotice
        label.font = .Pretendard(.bold, size: 12)
        label.textColor = .txt_secondary
        label.textAlignment = .center
        return label
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
         enterUsernameLabel,
         finalLabel,
         usernameTextfield,
         usernameNoticeLabel,
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
        
        enterUsernameLabel.snp.makeConstraints({
            $0.top.equalTo(logoImageView.snp.bottom).offset(9.6)
            $0.horizontalEdges.equalToSuperview()
        })
        
        finalLabel.snp.makeConstraints({
            $0.top.equalTo(enterUsernameLabel.snp.bottom).offset(7.0)
            $0.horizontalEdges.equalToSuperview()
        })
        
        usernameTextfield.snp.makeConstraints({
            $0.top.equalTo(finalLabel.snp.bottom).offset(23.0)
            $0.horizontalEdges.equalToSuperview().inset(24.0)
        })
        
        usernameNoticeLabel.snp.makeConstraints({
            $0.top.equalTo(usernameTextfield.snp.bottom).offset(103.0)
            $0.horizontalEdges.equalToSuperview()
        })
        
        continueButton.snp.makeConstraints({
            $0.top.equalTo(usernameNoticeLabel.snp.bottom).offset(10.0)
            $0.width.equalTo(380.0)
            $0.height.equalTo(45.0)
            $0.centerX.equalToSuperview()
        })
    }
    
    private func bind() {
        let input = SignUpWithUsernameViewModel
            .Input(usernameTextInput: usernameTextfield.textPublisher(),
                   continueButtonTapped: continueButton.rx.tap.asObservable())
        let output = viewModel?.transform(from: input)
        
        output?.usernameTextFieldOutput
            .subscribe(onNext: { [weak self] in
                self?.usernameTextfield.textFieldStateSubject.onNext($0)
            })
            .disposed(by: disposeBag)
        
        output?
            .continueButtonIsValid
            .subscribe(onNext: { state in
                self.enableContinueButton(state: state)
            }).disposed(by: disposeBag)
    }
    
    
    func enableContinueButton(state: Bool) {
        continueButton.isEnabled = state
        continueButton.setTitleColor(state ? .txt_component : .txt_disabled, for: .normal)
        continueButton.backgroundColor = state ? .component_primary : .component_disabled
    }
}
