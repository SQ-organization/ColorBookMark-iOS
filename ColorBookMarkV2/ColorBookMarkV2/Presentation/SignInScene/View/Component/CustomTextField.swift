//
//  CustomTextField.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/05/20.
//

import UIKit
import SnapKit
import RxSwift

final class CustomTextField: UIView {
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
    
    private let stateBar: UIView = UIView()
    
    private let errorLabel: UILabel = UILabel()
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupLayout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        [textField,
        stateBar,
        errorLabel]
            .forEach({ addSubview($0) })
        
        textField.snp.makeConstraints({
            $0.horizontalEdges.equalToSuperview()
        })
        
        stateBar.snp.makeConstraints({
            $0.top.equalTo(textField.snp.bottom).inset(3.0)
            $0.horizontalEdges.equalTo(textField)
            $0.height.equalTo(3.0)
        })
        
        errorLabel.snp.makeConstraints({
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
            self.stateBar.backgroundColor = .clear
            self.errorLabel.text = ""
        case .typing:
            self.stateBar.backgroundColor = .black
            self.errorLabel.text = ""
        case .error(message: let message):
            self.stateBar.backgroundColor = .red
            self.errorLabel.text = message
            self.errorLabel.textColor = .black
        case .done(message: let message):
            self.stateBar.backgroundColor = .black
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
