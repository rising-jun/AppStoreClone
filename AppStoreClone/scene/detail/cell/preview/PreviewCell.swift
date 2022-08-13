//
//  PreviewCell.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/12.
//

import UIKit

final class PreviewCell: UICollectionViewCell {
    static let id = String(describing: PreviewCell.self)
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
}
extension PreviewCell {
    private func layout() {
        addSubview(imageView)
        NSLayoutConstraint.activate( [imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
                                      imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
                                      imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
                                      imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)])
    }
    
    func setImage(data: Data) {
        imageView.image = UIImage(data: data)
    }
}
