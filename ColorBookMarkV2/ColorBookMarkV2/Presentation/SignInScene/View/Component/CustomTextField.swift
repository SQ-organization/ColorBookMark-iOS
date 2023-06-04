//
//  CustomTextField.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/05/20.
//

import UIKit
import SnapKit
import Combine

final class CustomTextField: UIView {
    var textFieldStateSubject: PassthroughSubject<TextFieldState, TextFieldError> = PassthroughSubject<TextFieldState, TextFieldError>()
    private var textFieldState: TextFieldState = .empty
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        return textField
    }()
    
    private let stateBar: UIView = UIView()
    override init(frame: CGRect) {
        super .init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        [textField,
        stateBar]
            .forEach({ addSubview($0) })
        
        textField.snp.makeConstraints({
            $0.horizontalEdges.equalToSuperview()
        })
        
        textField.snp.makeConstraints({
            $0.top.equalTo(textField.snp.bottom)
            $0.horizontalEdges.equalTo(textField)
        })
    }

}

extension CustomTextField {
    func setPlaceHolder(_ placeHolder: String) {
        textField.placeholder = placeHolder
    }
    
    func setReturnKey(_ keyType: UIKeyboardType) {
        textField.keyboardType = keyType
    }
    
    func setSecureMode(_ isSecureEntry: Bool) {
        textField.isSecureTextEntry = isSecureEntry
    }
    
//    func textPublisher() -> AnyPublisher<String?, Never> {
//        return textField.textPublisher.eraseToAnyPublisher()
//    }
//    
//    func textControlPublisher(_ control: UIControl.Event) -> AnyPublisher<Void, Never> {
//        return textField.controlEventPublisher(for: control).eraseToAnyPublisher()
//    }
}

enum TextFieldState {
    case empty
    case normal
    case error
}

enum TextFieldError: Error {
    case notEmailFormat
    case notMatchPassword
    case incorrectPassword
}
