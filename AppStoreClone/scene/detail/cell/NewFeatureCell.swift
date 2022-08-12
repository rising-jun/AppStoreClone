//
//  NewFeatureCell.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/12.
//

import UIKit

final class NewFeatureCell: UICollectionViewCell {
    static let id = String(describing: NewFeatureCell.self)
    static let cellCount = 1
    private let newVersionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "새로운 기능"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let versionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let noteLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
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
    
    override func prepareForReuse() {
        versionLabel.text = nil
        releaseDateLabel.text = nil
        noteLabel.text = nil
    }
}
extension NewFeatureCell {
    private func layout() {
        addSubviews(newVersionLabel, versionLabel, releaseDateLabel, noteLabel, dividerLine)
        NSLayoutConstraint.activate( [newVersionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
                                      newVersionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
                                      newVersionLabel.widthAnchor.constraint(equalToConstant: 150),
                                      newVersionLabel.heightAnchor.constraint(equalToConstant: 40)])
        
        NSLayoutConstraint.activate( [versionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
                                      versionLabel.topAnchor.constraint(equalTo: self.newVersionLabel.bottomAnchor, constant: 0),
                                      versionLabel.widthAnchor.constraint(equalToConstant: 100),
                                      versionLabel.heightAnchor.constraint(equalToConstant: 15)])
        
        NSLayoutConstraint.activate( [releaseDateLabel.centerYAnchor.constraint(equalTo: versionLabel.centerYAnchor),
                                      releaseDateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
                                      releaseDateLabel.widthAnchor.constraint(equalToConstant: 70),
                                      releaseDateLabel.heightAnchor.constraint(equalToConstant: 30)])
        
        NSLayoutConstraint.activate( [noteLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
                                      noteLabel.topAnchor.constraint(equalTo: self.versionLabel.bottomAnchor, constant: 0),
                                      noteLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
                                      noteLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)])
        
        NSLayoutConstraint.activate( [dividerLine.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -0.5),
                                      dividerLine.widthAnchor.constraint(equalTo: self.widthAnchor),
                                      dividerLine.heightAnchor.constraint(equalToConstant: 0.5),
                                      dividerLine.leadingAnchor.constraint(equalTo: self.leadingAnchor)])
    }
    
    func configuration(with entity: NewFeatureEntity?) {
        versionLabel.text = entity?.version
        releaseDateLabel.text = entity?.currentVersionDate
        let attrString = NSMutableAttributedString(string: entity?.releaseNotes ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 12
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        noteLabel.attributedText = attrString
        noteLabel.adjustsFontSizeToFitWidth = true
    }
}
