//
//  PreviewFooter.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/12.
//

import UIKit

final class PreviewFooter: UICollectionReusableView {
    static let id = String(describing: PreviewFooter.self)
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "iphone")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .gray
        return imageView
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "iPhone"
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 16)
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
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
extension PreviewFooter {
    private func layout() {
        addSubviews(iconImageView, phoneLabel, dividerLine)
        NSLayoutConstraint.activate([iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
                                     iconImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
                                     iconImageView.widthAnchor.constraint(equalToConstant: 20),
                                     iconImageView.heightAnchor.constraint(equalToConstant: 20)])
        
        NSLayoutConstraint.activate([phoneLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 5),
                                     phoneLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
                                     phoneLabel.widthAnchor.constraint(equalToConstant: 100),
                                     phoneLabel.heightAnchor.constraint(equalToConstant: 20)])
        
        NSLayoutConstraint.activate( [dividerLine.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -0.5),
                                      dividerLine.widthAnchor.constraint(equalTo: self.widthAnchor),
                                      dividerLine.heightAnchor.constraint(equalToConstant: 0.5),
                                      dividerLine.leadingAnchor.constraint(equalTo: self.leadingAnchor)])
    }
}

