//
//  CustomTextField.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/05/20.
//

import UIKit
import SnapKit
import RxSwift

final class CustomTextField: UIStackView {
    var textFieldStateSubject = PublishSubject<TextFieldState>()
    private var textFieldState: TextFieldState = .empty
    private var disposeBag = DisposeBag()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.light_G05?.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupLayout()
        bind()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setupLayout() {
        self.axis = .vertical
        self.distribution = .equalSpacing
        self.spacing = 6.0
        [textField,
        errorLabel]
            .forEach({ addArrangedSubview($0) })
        
        textField.snp.makeConstraints({
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48.0)
        })
        
        errorLabel.snp.makeConstraints({
            $0.horizontalEdges.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.top.equalTo(textField.snp.bottom).offset(6.0)
        })
    }
    
    private func bind() {
        textField.rx.text.orEmpty
            .subscribe { [weak self] value in
                if value.element?.isEmpty == true {
                    self?.textFieldState = .empty
                    self?.textFieldStateSubject.onNext(.empty)
                } else {
                    self?.textFieldState = .typing
                    self?.textFieldStateSubject.onNext(.typing)
                }
            }
            .disposed(by: disposeBag)
        
        textFieldStateSubject.subscribe(onNext: { [weak self] in
            self?.changeStatusBar(state: $0)
        })
        .disposed(by: disposeBag)
    }
    
    private func changeStatusBar(state: TextFieldState) {
        switch state {
        case .empty:
            self.errorLabel.text = ""
        case .typing:
            self.errorLabel.text = ""
        case .error(message: let message):
            self.errorLabel.text = message
            self.errorLabel.textColor = .black
        case .done(message: let message):
            self.errorLabel.text = message
            self.errorLabel.textColor = .black
        }
    }

}

extension CustomTextField {
    func setPlaceHolder(_ placeHolder: String) {
        textField.placeholder = placeHolder
    }
    
    func setReturnKey(_ keyType: UIReturnKeyType) {
        textField.returnKeyType = keyType
    }
    
    func setSecureMode(_ isSecureEntry: Bool) {
        textField.isSecureTextEntry = isSecureEntry
    }
    
    func textPublisher() -> Observable<String> {
        return textField.rx.text.orEmpty.asObservable()
    }
//    
//    func textControlPublisher(_ control: UIControl.Event) -> AnyPublisher<Void, Never> {
//        return textField.controlEventPublisher(for: control).eraseToAnyPublisher()
//    }
}

enum TextFieldState {
    case empty
    case typing
    case done(message: String)
    case error(message: String)
    
}

enum TextFieldError: Error {
    case notEmailFormat
    case notMatchPassword
    case incorrectPassword
}
