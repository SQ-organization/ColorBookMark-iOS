//
//  MonthPickerViewController.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/08/06.
//

import SnapKit
import UIKit

final class MonthPickerViewController: UIViewController {
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = StringConstant.chooseMonth
        label.textColor = .txt_primary
        label.font = .Pretendard(.bold, size: 20.0)
        return label
    }()
    
    private let dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close_FILL0_wght0_GRAD0_opsz24"), for: .normal)
        return button
    }()
    
    private let monthPickerView: MonthPickerView = MonthPickerView()
    
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle(StringConstant.completeToSelect, for: .normal)
        button.titleLabel?.font = .Pretendard(.bold, size: 16.0)
        button.titleLabel?.textColor = .txt_component
        button.backgroundColor = .component_primary
        return button
    }()
    
    private let containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(containerView)
        [headerLabel,
        dismissButton,
        monthPickerView,
        confirmButton]
            .forEach({ containerView.addSubview($0) })
        
        containerView.snp.makeConstraints({
            $0.horizontalEdges.bottom.equalToSuperview()
        })
        
        headerLabel.snp.makeConstraints({
            $0.top.equalToSuperview().inset(36.0)
            $0.leading.equalToSuperview().inset(24.0)
        })
        
        dismissButton.snp.makeConstraints({
            $0.centerY.equalTo(headerLabel)
            $0.trailing.equalToSuperview().inset(24.0)
        })
        
        monthPickerView.snp.makeConstraints({
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(headerLabel.snp.bottom).offset(16.0)
        })
        
        confirmButton.snp.makeConstraints({
            $0.horizontalEdges.bottom.equalToSuperview().inset(24.0)
            $0.height.equalTo(24.0)
            $0.top.equalTo(monthPickerView.snp.bottom).offset(16.0)
        })

        
        
        

    }
}
