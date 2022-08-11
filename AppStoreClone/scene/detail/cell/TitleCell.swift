//
//  TitleCell.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/11.
//

import UIKit

final class TitleCell: UICollectionViewCell {
    static let id = String(describing: TitleCell.self)
    static let cellCount = 1
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "title"
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.text = "subtitle"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("다운로드", for: .normal)
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    let shareIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "square.and.arrow.up")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .systemBlue
        return imageView
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
extension TitleCell {
    private func layout() {
        addSubviews(imageView, titleLabel, subTitleLabel, downloadButton, shareIcon, dividerLine)
        NSLayoutConstraint.activate( [imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
                                      imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
                                      imageView.widthAnchor.constraint(equalToConstant: 120),
                                      imageView.heightAnchor.constraint(equalToConstant: 120)])
        
        NSLayoutConstraint.activate( [titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
                                      titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
                                      titleLabel.widthAnchor.constraint(equalToConstant: 200),
                                      titleLabel.heightAnchor.constraint(equalToConstant: 30)])
        
        NSLayoutConstraint.activate( [subTitleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
                                      subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
                                      subTitleLabel.widthAnchor.constraint(equalToConstant: 150),
                                      subTitleLabel.heightAnchor.constraint(equalToConstant: 30)])
        
        NSLayoutConstraint.activate( [downloadButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
                                      downloadButton.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
                                      downloadButton.widthAnchor.constraint(equalToConstant: 80),
                                      downloadButton.heightAnchor.constraint(equalToConstant: 30)])
        
        NSLayoutConstraint.activate( [shareIcon.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
                                      shareIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
                                      shareIcon.widthAnchor.constraint(equalToConstant: 30),
                                      shareIcon.heightAnchor.constraint(equalToConstant: 30)])
        
        NSLayoutConstraint.activate( [dividerLine.topAnchor.constraint(equalTo: self.bottomAnchor),
                                      dividerLine.widthAnchor.constraint(equalTo: self.widthAnchor),
                                      dividerLine.heightAnchor.constraint(equalToConstant: 0.5),])
    }
    
    func configuration(with entity: TitleEntity) {
        titleLabel.text = entity.title
        subTitleLabel.text = entity.subTitle
    }
    
    func configuration(imageData: Data) {
        imageView.image = UIImage(data: imageData)
    }
}
