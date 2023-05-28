//
//  SignInWithEmailViewController.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/04/23.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

final class SignInWithEmailViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    var viewModel: SignInWithEmailViewModel?
    
    private var emailTitleLabel: UILabel = {
        let label = UILabel()
        label.text = StringConstant.startColorBookMark
        label.font = .Pretendard(.medium, size: 16)
        label.textColor = .light_B02_Text
        label.textAlignment = .center
        return label
    }()
    
    private var cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "icClose"), for: .normal)
        return button
    }()
    
    private var logoImageView: UIImageView = {
        let image = UIImage(named: "logoImage")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    private var enterEmailLabel: UILabel = {
        let label = UILabel()
        label.text = StringConstant.enterEmail
        label.font = .Pretendard(.bold, size: 24)
        label.textColor = .light_B02_Text
        label.textAlignment = .center
        return label
    }()
    
    private var emailHandlingLabel: UILabel = {
        let label = UILabel()
        label.text = StringConstant.emailHandling
        label.font = .Pretendard(.medium, size: 16)
        label.textColor = .light_B02_Text
        label.textAlignment = .center
        return label
    }()
    
    private var emailTextfield: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = StringConstant.emailPlaceholder
        textfield.layer.cornerRadius = 5
        textfield.layer.borderColor = UIColor.light_G05?.cgColor
        textfield.layer.borderWidth = 1
        return textfield
        
    }()
    
    private var emailWarningLabel: UILabel = {
        let label = UILabel()
        label.text = StringConstant.emailWarning
        label.font = .Pretendard(.medium, size: 12)
        label.textColor = .light_Error
        label.textAlignment = .center
        return label
    }()
    
    private var emailNoticeLabel: UILabel = {
        let label = UILabel()
        label.text = StringConstant.emailNotice
        label.font = .Pretendard(.bold, size: 12)
        label.textColor = .light_B02_Text
        label.textAlignment = .center
        return label
    }()
    
    private var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle(StringConstant.continueText, for: .normal)
        button.titleLabel?.font = .Pretendard(.bold, size: 16)
        button.setTitleColor(.veryLightPink, for: .normal)
        button.backgroundColor = .light_G02
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
        
        [emailTitleLabel,
         cancelButton,
         logoImageView,
         enterEmailLabel,
         emailHandlingLabel,
         emailTextfield,
         emailWarningLabel,
         emailNoticeLabel,
         continueButton]
            .forEach({ view.addSubview($0) })
        
        emailTitleLabel.snp.makeConstraints({
            $0.top.equalToSuperview().inset(72.0)
            $0.horizontalEdges.equalToSuperview()
        })
        
        cancelButton.snp.makeConstraints({
            $0.width.height.equalTo(44.0)
        })
        
        logoImageView.snp.makeConstraints({
            $0.top.equalTo(emailTitleLabel.snp.bottom).offset(13.9)
            $0.width.equalTo(120.0)
            $0.height.equalTo(96.4)
            $0.centerX.equalToSuperview()
        })
        
        enterEmailLabel.snp.makeConstraints({
            $0.top.equalTo(logoImageView.snp.bottom).offset(9.6)
            $0.horizontalEdges.equalToSuperview()
        })
        
        emailHandlingLabel.snp.makeConstraints({
            $0.top.equalTo(enterEmailLabel.snp.bottom).offset(7.0)
            $0.horizontalEdges.equalToSuperview()
        })
        
        emailTextfield.snp.makeConstraints({
            $0.top.equalTo(emailHandlingLabel.snp.bottom).offset(23.0)
            $0.width.equalTo(380.0)
            $0.height.equalTo(48.0)
            $0.centerX.equalToSuperview()
        })
        
        emailWarningLabel.snp.makeConstraints({
            $0.top.equalTo(emailTextfield.snp.bottom).offset(8.0)
            $0.horizontalEdges.equalToSuperview()
        })
        
        emailNoticeLabel.snp.makeConstraints({
            $0.top.equalTo(emailTextfield.snp.bottom).offset(121.0)
            $0.horizontalEdges.equalToSuperview()
        })
        
        continueButton.snp.makeConstraints({
            $0.top.equalTo(emailNoticeLabel.snp.bottom).offset(12.0)
            $0.width.equalTo(380.0)
            $0.height.equalTo(45.0)
            $0.centerX.equalToSuperview()
        })
    }
    
    private func bind() {
        let input = SignInWithEmailViewModel
            .Input(emailTextInput: self.emailTextfield.textPublisher,
                   continueButtonTapped: continueButton.tapPublisher)
        let output = viewModel?.transform(from: input)
        
        output?
            .continueButtonIsValid
            .sink(receiveValue: { [weak self] state in
                self?.continueButton.isEnabled = state
                self?.continueButton.setTitleColor(state ? .light_G00 : .veryLightPink, for: .normal)
                self?.continueButton.backgroundColor = state ? .light_B01 : .light_G02
            })
            .store(in: &cancellables)
        
        output?
            .emailTextInvalid
            .sink(receiveValue: { [weak self] state in
                if state {      // email state invalid
                    self?.emailWarningLabel.isHidden = false
                    self?.emailTextfield.setUnderline(color: .light_Error!)
                }
                else {          // email state valid
                    self?.emailWarningLabel.isHidden = true
                    self?.emailTextfield.setUnderline(color: .light_B01!)
                    
                }
            })
            .store(in: &cancellables)
    }
}
