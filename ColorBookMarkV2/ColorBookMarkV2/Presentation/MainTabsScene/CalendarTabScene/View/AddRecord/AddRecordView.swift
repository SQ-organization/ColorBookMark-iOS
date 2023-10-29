//
//  AddRecordView.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/09/03.
//

import SnapKit
import UIKit

final class AddRecordView: UIViewController {
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let topTitleLabel: UILabel = {
        let label = UILabel()
        label.text = StringConstant.whatIsTodayColor
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
}

extension AddRecordView {
    private func setupLayout() {
        self.view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        [topTitleLabel]
            .forEach({ contentView.addSubview($0) })
        
        topTitleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview(traits: .portrait, body: {    AddRecordView()
})
