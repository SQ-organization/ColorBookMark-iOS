//
//  AddRecordButtonView.swift
//  ColorBookMarkV2
//
//  Created by SUN on 11/5/23.
//

import Foundation
import UIKit

final class AddRecordButtonView: UIView {
    private let logoImage: UIImageView = {
        let image = UIImage(named: "Logo_Medium")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.text = StringConstant.letsRecordEmotionWithColor
        label.textColor = .txt_primary
        label.font = .Pretendard(.bold, size: 16.0)
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = StringConstant.goingToAddRecord
        label.textColor = .txt_primary
        label.font = .Pretendard(.medium, size: 14.0)
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let image = UIImage(named: "navigate_next_black_16")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .gray_04
        layer.cornerRadius = 16.0
        [logoImage, titleLabel, subTitleLabel, arrowImageView]
            .forEach({ addSubview($0) })
        
        logoImage.snp.makeConstraints({
            $0.verticalEdges.equalToSuperview().inset(16.0)
            $0.leading.equalToSuperview().inset(24.0)
        })
        
        titleLabel.snp.makeConstraints({
            $0.leading.equalTo(logoImage.snp.trailing).offset(24.0)
            $0.bottom.equalTo(logoImage.snp.centerY)
        })
        
        subTitleLabel.snp.makeConstraints({
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(3.0)
        })
        
        arrowImageView.snp.makeConstraints({
            $0.leading.equalTo(subTitleLabel.snp.trailing)
            $0.centerY.equalTo(subTitleLabel)
        })
    }
    
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview(traits: .portrait, body: {
    AddRecordButtonView()
})
