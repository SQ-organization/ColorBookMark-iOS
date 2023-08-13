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
    
    private let complete: ((Date) -> Void)?
    private var selectedDate: Date = Date()
    private weak var delegate: SelectMonthDelegate?
    
    init(complete: ((Date) -> Void)? = nil,
         delegate: SelectMonthDelegate) {
        self.complete = complete
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configuration()
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
    
    private func configuration() {
        monthPickerView.onDateSelected = { [weak self] date in
            self?.selectedDate = date
        }
        confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        dismissButton.addTarget(self, action: #selector(didTapDismissButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapConfirmButton() {
        delegate?.selectMonth(month: selectedDate)
        self.dismiss(animated: true)
    }
    
    @objc
    private func didTapDismissButton() {
        self.dismiss(animated: true)
    }
}
