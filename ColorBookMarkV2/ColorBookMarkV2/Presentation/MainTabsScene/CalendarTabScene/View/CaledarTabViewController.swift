//
//  CaledarTabViewController.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/06/23.
//

import UIKit
import SnapKit
import RxSwift

final class CaledarTabViewController: UIViewController {
    private let disposeBag = DisposeBag()
    var viewModel: CalendarTabViewModel?

    private var week: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    private var daysInSelectedMonth: [String] = []
    
    private let monthButton: UIButton = {
        let button = UIButton()
        button.setTitle(Date().toString(format: "yyyy.MM"), for: .normal)
        button.setImage(UIImage(named: "arrow_drop_down_black_24"), for: .normal)
        button.titleLabel?.font = .Pretendard(.bold, size: 20.0)
        button.setTitleColor(.txt_primary, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
    
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private let weekColumnStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .blue
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        self.navigationItem.titleView = monthButton
        setupLayout()
        configuration()
        bindViewModel()
    }
    

    private func setupLayout() {
       
        [weekColumnStackView,
         collectionView]
            .forEach({ view.addSubview($0) })
        
        week.forEach({
            let label = UILabel()
            label.text = $0
            label.font = .Pretendard(.bold, size: 14.0)
            label.textColor = $0 == "일" ? .sub_error : .txt_primary
            label.textAlignment = .center
            weekColumnStackView.addArrangedSubview(label)
        })
        
        weekColumnStackView.snp.makeConstraints({
            $0.horizontalEdges.equalToSuperview().inset(20.0)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(24.0)
//            $0.height.equalTo(30.0)
        })
        collectionView.snp.makeConstraints({
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(24.0)
            $0.top.equalTo(weekColumnStackView.snp.bottom).offset(32.0)
        })
    }
    
    private func configuration() {
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
        
    }
    
    private func bindViewModel() {
        let input = CalendarTabViewModel.Input(didTapCalendarCell: collectionView.rx.itemSelected.map({ $0.item }),
                                               changeMonth: monthButton.rx.tap.asObservable())
        let output = viewModel?.transform(from: input)
        
        output?.selectedMonthText
            .subscribe(onNext: { [weak self] month in
                self?.monthButton.setTitle(month, for: .normal)
            })
            .disposed(by: disposeBag)
        
        output?.selectedMonthInfo
            .subscribe(onNext: {[weak self] days in
                self?.daysInSelectedMonth = days
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension CaledarTabViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysInSelectedMonth.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as? CalendarCollectionViewCell else { return UICollectionViewCell() }
        cell.setupLayout(date: daysInSelectedMonth[indexPath.item])
        return cell
    }
    
  
}

extension CaledarTabViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth: CGFloat = UIScreen.main.bounds.size.width
        let cellSize : CGFloat = (screenWidth - 48) / 9
        return CGSize(width: cellSize, height: cellSize)
    }
}



//@IBOutlet weak var yearMonthLabel: UILabel!
//    @IBOutlet weak var collectionView: UICollectionView!
//
//    let now = Date()
//    var cal = Calendar.current
//    let dateFormatter = DateFormatter()
//    var components = DateComponents()
//    var weeks: [String] = ["日", "月", "火", "水", "木", "金", "土"]
//    var days: [String] = []
//    var daysCountInMonth = 0
//    var weekdayAdding = 0
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.initView()
//    }
//
//    private func initView() {
//        self.initCollection()
//
//        dateFormatter.dateFormat = "yyyy年M月"
//        components.year = cal.component(.year, from: now)
//        components.month = cal.component(.month, from: now)
//        components.day = 1
//        self.calculation()
//    }
//
//    private func initCollection() {
//        self.collectionView.delegate = self
//        self.collectionView.dataSource = self
//        self.collectionView.register(UINib(nibName: "CalendarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "calendarCell")
//        self.collectionView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:))))
//    }
//
//    private func calculation() {
//        let firstDayOfMonth = cal.date(from: components)
//        let firstWeekday = cal.component(.weekday, from: firstDayOfMonth!)
//        daysCountInMonth = cal.range(of: .day, in: .month, for: firstDayOfMonth!)!.count
//        weekdayAdding = 2 - firstWeekday
//
//        self.yearMonthLabel.text = dateFormatter.string(from: firstDayOfMonth!)
//
//        self.days.removeAll()
//        for day in weekdayAdding...daysCountInMonth {
//            if day < 1 {
//                self.days.append("")
//            } else {
//                self.days.append(String(day))
//            }
//        }
//    }
//
//    @IBAction func didTappedPrevButton(_ sender: UIButton) {
//        components.month = components.month! - 1
//        self.calculation()
//        self.collectionView.reloadData()
//    }
//
//    @IBAction func didTappedNextButton(_ sender: UIButton) {
//        components.month = components.month! + 1
//        self.calculation()
//        self.collectionView.reloadData()
//    }
//}
//
//extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 2
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return 7
//        default:
//            return self.days.count
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CalendarCollectionViewCell
//
//        switch indexPath.section {
//        case 0:
//            cell.dateLabel.text = weeks[indexPath.row]
//        default:
//            cell.dateLabel.text = days[indexPath.row]
//        }
//
//        if indexPath.row % 7 == 0 {
//            cell.dateLabel.textColor = .red
//        } else if indexPath.row % 7 == 6 {
//            cell.dateLabel.textColor = .blue
//        } else {
//            cell.dateLabel.textColor = .black
//        }
//
//        return cell
//    }
//}
//
//extension ViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let myBoundSize: CGFloat = UIScreen.main.bounds.size.width
//        let cellSize : CGFloat = myBoundSize / 9
//        return CGSize(width: cellSize, height: cellSize)
//    }
//}
