//
//  PreviewHeader.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/12.
//

import UIKit

final class PreviewHeader: UICollectionReusableView {
    static let id = String(describing: PreviewHeader.self)
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "미리보기"
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
extension PreviewHeader {
    private func layout() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
                                      titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
                                      titleLabel.widthAnchor.constraint(equalToConstant: 150),
                                      titleLabel.heightAnchor.constraint(equalToConstant: 30)])
    }
}
