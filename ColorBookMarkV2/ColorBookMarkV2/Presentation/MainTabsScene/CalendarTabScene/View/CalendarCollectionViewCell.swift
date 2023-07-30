//
//  CalendarCollectionViewCell.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/07/13.
//

import UIKit
import SnapKit

final class CalendarCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "CalendarCollectionViewCell"
    private let dateColorCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray_03
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dateColorCircleView.layer.cornerRadius = (contentView.frame.width - 8.0) * 0.5
        dateColorCircleView.layer.borderWidth = 1.0
        dateColorCircleView.layer.borderColor = UIColor.gray_04?.cgColor
        dateColorCircleView.layer.masksToBounds = true
        layoutIfNeeded()

    }
    
    func setupLayout(date: String) {
        if date.isEmpty == true {
            return
        } else if isBeforeToday(date: date) == true {
            setupLayoutBeforeToday(date: date)
        } else {
            setupLayoutAfterToday(date: date)
        }
    }
    
    private func setupLayoutAfterToday(date: String) {
        contentView.addSubview(dateLabel)
        dateLabel.text = date
        dateLabel.font = .Pretendard(.medium, size: 16.0)
       
        dateLabel.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
    
    private func setupLayoutBeforeToday(date: String) {
        [dateColorCircleView,
        dateLabel]
            .forEach({ contentView.addSubview($0) })
        
        dateColorCircleView.snp.makeConstraints({
            $0.horizontalEdges.top.equalToSuperview().inset(4.0)
            $0.height.equalTo(dateColorCircleView.snp.width)
        })
        
        dateLabel.snp.makeConstraints({
            $0.top.equalTo(dateColorCircleView.snp.bottom).offset(4.0)
            $0.centerX.equalToSuperview()
        })
        
        dateLabel.text = date
        dateLabel.font = .Pretendard(.medium, size: 12.0)
       
    }
    
    private func isBeforeToday(date: String) -> Bool {
        return Int(Date().toString(format: "d")) ?? 0 > Int(date) ?? 0
    }
}


enum CalendarCellType {
    case beforeToday
    case beforeTodayWithEmotion
    case today
    case todayWithEmotion
    case afterToday
}
