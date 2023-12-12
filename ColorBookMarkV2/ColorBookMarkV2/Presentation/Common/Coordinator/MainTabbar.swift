//
//  MainTabbar.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/06/23.
//

import Foundation

enum MainTabbar: String {
    case calendar
    case record
    case statistics
    case setting
    
    init?(index: Int) {
        switch index {
        case 0:
            self = .calendar
        case 1:
            self = .record
        case 2:
            self = .statistics
        case 3:
            self = .setting
        default:
            return nil
        }
    }
    
    /// 탭바 태그
    var tabbarTag: Int {
        switch self {
        case .calendar:
            return 0
        case .record:
            return 1
        case .statistics:
            return 2
        case .setting:
            return 3
        }
    }
    
    /// 탭바 선택한 이미지
    var selectedImageName: String {
        return String(format: "%@_tab_selected", self.rawValue)
    }
    
    /// 탭바 기본 이미지
    var unselectedImageName: String {
        return String(format: "%@_tab_unselected", self.rawValue)
    }
    
    /// 탭바 타이틀
    var title: String {
        switch self {
        case .calendar:
            return StringConstant.calendarTab
        case .record:
            return StringConstant.recordTab
        case .statistics:
            return StringConstant.statisticsTab
        case .setting:
            return StringConstant.settingTab
        }
    }
}
