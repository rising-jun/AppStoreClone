//
//  InfoHeader.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/13.
//

import UIKit

final class InfoHeader: UICollectionReusableView {
    static let id = String(describing: InfoHeader.self)
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "정보"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
extension InfoHeader {
    private func layout() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
                                      titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
                                      titleLabel.widthAnchor.constraint(equalToConstant: 150),
                                      titleLabel.heightAnchor.constraint(equalToConstant: 30)])
    }
}

