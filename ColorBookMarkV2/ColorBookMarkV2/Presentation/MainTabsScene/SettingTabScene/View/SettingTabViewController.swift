//
//  SettingTabViewController.swift
//  ColorBookMarkV2
//
//  Created by SUN on 11/26/23.
//

import Foundation
import UIKit

final class SettingTabViewController: UIViewController {
    private let topTitleLabel: UILabel = {
        let label = UILabel()
        label.text = StringConstant.setting
        label.textColor = .txt_primary
        return label
    }()
    
    private let scrollView: UIScrollView = UIScrollView()
    
    private let contentView: UIView = UIView()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16.0
        return stackView
    }()
    
    private let alertSettingCellView: SettingTabCellWithSwitchView = SettingTabCellWithSwitchView(title: "ggddiofjiwejfoiewjiofjoiajfojewoifjweoifjoiawejfiojweifjoiaewjfoiawejfaioewj", subTitle: "Gg", isOn: false)
    
    private let darkModeSettingCellView: SettingTabCellWithSwitchView = SettingTabCellWithSwitchView(title: "ggddiofjiwejfoiewjiofjoiajfojewoifjweoifjoiawejfiojweifjoiaewjfoiawejfaioewj", subTitle: "Gg", isOn: false)
    
    private let backupInformationCellView: SettingTabCellView = SettingTabCellView(title: "gg")
    
    private let introduceInformationCellView: SettingTabCellView = SettingTabCellView(title: "gg")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout() 
    }
    
    private func setupLayout() {
        [topTitleLabel,
         scrollView]
            .forEach({ view.addSubview($0) })
        
        [alertSettingCellView,
         darkModeSettingCellView,
         backupInformationCellView,
         introduceInformationCellView]
            .forEach({ verticalStackView.addArrangedSubview($0) })
        
        topTitleLabel.snp.makeConstraints({
            $0.centerX.top.equalTo(view.safeAreaLayoutGuide)
        })
        
        scrollView.snp.makeConstraints({
            $0.top.equalTo(topTitleLabel.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        })
        
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints({
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        })
        
        contentView.addSubview(verticalStackView)
        
        verticalStackView.snp.makeConstraints({
            $0.top.equalToSuperview()
                .inset(16.0)
            $0.horizontalEdges.equalToSuperview().inset(16.0)
        })
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview(traits: .portrait, body: {
    SettingTabViewController()
})
