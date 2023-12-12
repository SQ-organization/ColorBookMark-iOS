//
//  PopupViewController.swift
//  Release
//
//  Created by SUN on 2023/06/14.
//

import UIKit
import SnapKit

final class PopupViewController: UIViewController {
    private var titleInfo: String
    private var subTitleInfo: String?
    private var leftButtonText: String?
    private var rightButtonText: String?
    private let leftButtonTapped: (() -> Void)?
    private let rightButtonTapped: () -> Void?
    private lazy var logoView: UIImageView = {
        let image = UIImage(named: "Logo_Medium")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20.0
        view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        return view
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12.0
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var horizontalButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 14.0
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = titleInfo
        label.textColor = .black
        label.textAlignment = .center
        label.font = .Pretendard(.bold, size: 20.0)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = subTitleInfo
        label.textColor = .black
        label.textAlignment = .center
        label.font = .Pretendard(.medium, size: 13.0)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(rightButtonText, for: .normal)
        button.titleLabel?.textColor = .white
        button.layer.backgroundColor = UIColor.black.cgColor
        button.layer.cornerRadius = 14.0
        button.addTarget(self, action: #selector(rightButtonTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(leftButtonText, for: .normal)
        button.titleLabel?.textColor = .black
        button.layer.backgroundColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 14.0
        button.addTarget(self, action: #selector(leftButtonTap), for: .touchUpInside)
        return button
    }()
    
    init(title: String, subTitleInfo: String? = nil, leftButtonText: String? = nil, rightButtonText: String?, leftButtonTapped: (() -> Void)? = nil, rightButtonTapped: @escaping () -> Void?) {
        self.titleInfo = title
        self.subTitleInfo = subTitleInfo
        self.leftButtonText = leftButtonText
        self.rightButtonText = rightButtonText
        self.leftButtonTapped = leftButtonTapped
        self.rightButtonTapped = rightButtonTapped
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.2, delay: 0.0) { [weak self] in
            self?.containerView.transform = .identity
            self?.containerView.isHidden = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.animate(withDuration: 0.2, delay: 0.0) { [weak self] in
            self?.containerView.transform = .identity
            self?.containerView.isHidden = true
        }
    }
    
    private func setupLayout() {
        view.backgroundColor = .black.withAlphaComponent(0.3)
        view.addSubview(containerView)
        view.addSubview(logoView)
        containerView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        if subTitleInfo != nil {
            verticalStackView.addArrangedSubview(subTitleLabel)
        }
        verticalStackView.addArrangedSubview(horizontalButtonsStackView)
        if leftButtonText != nil {
            horizontalButtonsStackView.addArrangedSubview(cancelButton)
        }
        horizontalButtonsStackView.addArrangedSubview(confirmButton)
        
        
        containerView.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(59.0)
        })
        
        logoView.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(containerView.snp.top)
        })
        
        verticalStackView.snp.makeConstraints({
            $0.horizontalEdges.equalToSuperview().inset(20.0)
            $0.verticalEdges.equalToSuperview().inset(42.0)
        })
        
        horizontalButtonsStackView.snp.makeConstraints({
            $0.horizontalEdges.equalToSuperview().inset(20.0)
            $0.height.equalTo(28.0)
        })
    }
}

extension PopupViewController {
    @objc private func rightButtonTap() {
        rightButtonTapped()
        self.dismiss(animated: false)
    }
    
    @objc private func leftButtonTap() {
        leftButtonTapped?()
        self.dismiss(animated: false)
    }
}

extension UIViewController {
    func  showPopUp(title: String,
                    subTitleInfo: String? = nil,
                    leftButtonText: String? = nil,
                    rightButtonText: String?,
                    leftButtonTapped: (() -> Void)? = nil,
                    rightButtonTapped: (() -> Void)? = nil) {
        let popUpViewController = PopupViewController(title: title,
                                                      subTitleInfo: subTitleInfo,
                                                      leftButtonText: leftButtonText,
                                                      rightButtonText: rightButtonText,
                                                      leftButtonTapped:  { leftButtonTapped?()
        },
                                                      rightButtonTapped: {
            rightButtonTapped?()
        })
        present(popUpViewController, animated: false, completion: nil)
        
    }
    private func showPopUp(popUpViewController: PopupViewController,
                           title: String,
                           subTitleInfo: String? = nil,
                           leftButtonText: String? = nil,
                           rightButtonText: String?,
                           leftButtonTapped: (() -> Void)? = nil,
                           rightButtonTapped: () -> Void?) {
       
            
        }
}
