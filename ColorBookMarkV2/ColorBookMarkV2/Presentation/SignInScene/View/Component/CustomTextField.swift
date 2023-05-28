//
//  CustomTextField.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/05/20.
//

import UIKit

final class CustomTextField: UIView {
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = StringConstant.placeHolderForTextField
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
}

