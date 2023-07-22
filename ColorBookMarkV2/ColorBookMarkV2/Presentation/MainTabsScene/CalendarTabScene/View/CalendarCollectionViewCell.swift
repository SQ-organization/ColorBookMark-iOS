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
    var date: String = "10"
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    
    override func layoutSubviews() {
//        setupLayout()
//        contentView.backgroundColor = .red
    }
    
    func setupLayout(date: String) {
        contentView.addSubview(dateLabel)
        dateLabel.text = date
        dateLabel.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
}


enum CalendarCellType {
    case beforeToday
    case beforeTodayWithEmotion
    case today
    case todayWithEmotion
    case afterToday
}
