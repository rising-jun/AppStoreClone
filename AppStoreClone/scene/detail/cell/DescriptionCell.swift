//
//  DescriptionCell.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/13.
//

import UIKit

final class DescriptionCell: UICollectionViewCell {
    static let id = String(describing: DescriptionCell.self)
    static let cellCount = 1
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.setTitle("더 보기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.titleLabel?.textAlignment = .center
        button.layer.zPosition = 999
        return button
    }()
    
    private let sellerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let developerLabel: UILabel = {
        let label = UILabel()
        label.text = "개발자"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let dividerLine: UIView = {
        let line = UIView()
        line.backgroundColor = .gray
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    private var descriptionConstraints = [NSLayoutConstraint]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        bind()
    }
    
    private var expendAction: (() -> ())?
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func prepareForReuse() {
        descriptionLabel.text = nil
        sellerLabel.text = nil
    }
}
extension DescriptionCell {
    private func layout() {
        addSubviews(moreButton, descriptionLabel, sellerLabel, developerLabel, dividerLine)
        descriptionConstraints = [descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
                                      descriptionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
                                      descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
                                      descriptionLabel.heightAnchor.constraint(equalToConstant: 100)]
        NSLayoutConstraint.activate(descriptionConstraints)
        
        NSLayoutConstraint.activate([moreButton.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
                                     moreButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
                                     moreButton.widthAnchor.constraint(equalToConstant: 80),
                                     moreButton.heightAnchor.constraint(equalToConstant: 25)])
        
        NSLayoutConstraint.activate([sellerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
                                     sellerLabel.bottomAnchor.constraint(equalTo: developerLabel.topAnchor),
                                     sellerLabel.widthAnchor.constraint(equalToConstant: 120),
                                     sellerLabel.heightAnchor.constraint(equalToConstant: 25)])
        
        NSLayoutConstraint.activate([developerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
                                     developerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40),
                                     developerLabel.widthAnchor.constraint(equalToConstant: 50),
                                     developerLabel.heightAnchor.constraint(equalToConstant: 25)])
        
        NSLayoutConstraint.activate( [dividerLine.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -0.5),
                                      dividerLine.widthAnchor.constraint(equalTo: self.widthAnchor),
                                      dividerLine.heightAnchor.constraint(equalToConstant: 0.5),
                                      dividerLine.leadingAnchor.constraint(equalTo: self.leadingAnchor)])
    }
    
    private func bind() {
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
    }
    
    @objc func moreButtonTapped(sender: Any) {
        expendAction?()
        expendLayout()
    }
    
    func configuration(with entity: DescriptionEntityUsable) {
        self.expendAction = entity.getMoreDescriptionAction()
        let attrString = NSMutableAttributedString(string: entity.getDescription())
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        descriptionLabel.attributedText = attrString
        descriptionLabel.adjustsFontSizeToFitWidth = true
        sellerLabel.text = entity.getSellerName()
        
        if entity.isExpendDescription() {
            expendLayout()
        }
    }
    
    func expendLayout() {
        moreButton.removeFromSuperview()
        
        UIView.animate(withDuration: 0.2) {
            self.descriptionLabel.numberOfLines = 0
            self.descriptionLabel.removeConstraints(self.descriptionConstraints)
            let descriptionExpendConstraints = [self.descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
                                                self.descriptionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
                                                self.descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
                                                self.descriptionLabel.bottomAnchor.constraint(equalTo: self.sellerLabel.topAnchor, constant: -20)]
            NSLayoutConstraint.activate(descriptionExpendConstraints)
            self.layoutIfNeeded()
        }
    }
}
