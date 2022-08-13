//
//  InfoCell.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/13.
//

import UIKit

final class InfoCell: UICollectionViewCell {
    static let id = String(describing: InfoCell.self)
    static let cellCount = 5
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "정보"
        label.textColor = .systemGray4
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "ㄴㅐ용"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dividerLine: UIView = {
        let line = UIView()
        line.backgroundColor = .gray
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bind()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
extension InfoCell {
    private func bind() {
        addSubviews(titleLabel, contentLabel, dividerLine)
        
        NSLayoutConstraint.activate([titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
                                      titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                      titleLabel.widthAnchor.constraint(equalToConstant: 100),
                                      titleLabel.heightAnchor.constraint(equalToConstant: 30)])
        
        NSLayoutConstraint.activate([contentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
                                     contentLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                     contentLabel.widthAnchor.constraint(equalToConstant: 250),
                                     contentLabel.heightAnchor.constraint(equalToConstant: 30)])
        
        NSLayoutConstraint.activate( [dividerLine.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -0.5),
                                      dividerLine.widthAnchor.constraint(equalTo: self.widthAnchor),
                                      dividerLine.heightAnchor.constraint(equalToConstant: 0.5),
                                      dividerLine.leadingAnchor.constraint(equalTo: self.leadingAnchor)])
    }
    
    func configuration(title titleText: String, contents contentsText: String?) {
        titleLabel.text = titleText
        contentLabel.text = contentsText
    }
    
    func configuration(title titleText: String, contents contentsText: [String]?) {
        titleLabel.text = titleText
        contentLabel.text = contentsText?.first
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        contentLabel.text = nil
    }
}

enum InfoSequence: Int {
    case provider
    case reviewRating
    case appSize
    case category
    case surpportDevice
}
extension InfoSequence {
    var title: String {
        switch self {
        case .provider:
            return "제공"
        case .reviewRating:
            return "평점"
        case .appSize:
            return "크기"
        case .category:
            return "카테고리"
        case .surpportDevice:
            return "호환성"
        }
    }
}
