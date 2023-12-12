//
//  SettingTabCellView.swift
//  ColorBookMarkV2
//
//  Created by SUN on 12/3/23.
//

import UIKit
import SnapKit

final class SettingTabCellView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .txt_primary
        return label
    }()
    
    private let title: String
    
    init(title: String) {
        self.title = title
        super.init(frame: .init())
        
        configuration()
        setupLayout()

       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configuration() {
        titleLabel.text = title
    }
    
    private func setupLayout() {
        self.backgroundColor = .background_elevated
        self.layer.cornerRadius = 8.0
        
        [titleLabel]
            .forEach({ addSubview($0) })
        
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16.0)
        }
        titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview(traits: .portrait, body: {
    SettingTabCellView(title: "ggdafdfsdafsfwefewfewfewfewfewfwefwefedfdf")
})
