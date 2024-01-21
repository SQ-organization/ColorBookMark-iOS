//
//  UserNameCellView.swift
//  ColorBookMarkV2
//
//  Created by SUN on 12/3/23.
//

import UIKit
import SnapKit

final class UserNameCellView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .txt_primary
        label.font = .Pretendard(.bold, size: 28.0)
        return label
    }()
    
    private let myInformationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .txt_primary
        label.text = "내정보"
        label.font = .Pretendard(.medium, size: 14.0)
        return label
    }()
    
    private let rightArrowImageView: UIImageView = {
        let image = UIImage(named: "arrow_right_black_24")
        let imageView = UIImageView(image: image)
        
        return imageView
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .component_primary
        return view
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
        
        [titleLabel,
         myInformationLabel,
        rightArrowImageView,
         dividerView]
            .forEach({ addSubview($0) })
        
        myInformationLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        myInformationLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        rightArrowImageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        titleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(4.0)

        }
       
        myInformationLabel.snp.makeConstraints({
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing) .offset(8.0)

        })
        
        rightArrowImageView.snp.makeConstraints({
            $0.leading.equalTo(myInformationLabel.snp.trailing)
            $0.centerY.equalTo(myInformationLabel)
            $0.trailing.equalToSuperview().inset(4.0)
        })
        
        dividerView.snp.makeConstraints({
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(12.0)
            $0.height.equalTo(2.0)
        })
        
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview(traits: .portrait, body: {
    UserNameCellView(title: "ggdafdfsefedfdf")
})
