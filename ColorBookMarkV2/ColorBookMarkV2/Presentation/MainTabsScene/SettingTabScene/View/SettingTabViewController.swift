//
//  SettingTabViewController.swift
//  ColorBookMarkV2
//
//  Created by SUN on 11/26/23.
//

import Foundation
import UIKit

final class SettingTabViewController: UIViewController {
    private let topTitle: UILabel = {
        let label = UILabel()
        label.text = StringConstant.setting
        label.textColor = .txt_primary
        return label
    }()
    
    private let scrollView: UIScrollView = UIScrollView()
    
    private let contentView: UIView = UIView()
    
    private let cellView = SettingTabCellView(title: "ggddiofjiwejfoiewjiofjoiajfojewoifjweoifjoiawejfiojweifjoiaewjfoiawejfaioewj", subTitle: "Gg", isOn: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout() 
    }
    
    private func setupLayout() {
        [cellView]
            .forEach({ view.addSubview($0) })
        
        cellView.snp.makeConstraints({
            $0.horizontalEdges.top.equalToSuperview().inset(16.0)
        })
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview(traits: .portrait, body: {
    SettingTabViewController()
})
