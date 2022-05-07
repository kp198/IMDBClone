//
//  MovieCell.swift
//  PhonePeMC
//
//  Created by Keerthika Priya G on 07/05/22.
//

import Foundation
import UIKit

class MovieCell: UITableViewCell {
    let imgeView = UIImageView.init()
    let titleLabel = UILabel.init()
    let descrpnLabel  = UILabel.init()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "cell")
        setUpTableCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpTableCell() {
        self.contentView.addSubview(imgeView)
        imgeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([imgeView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10), imgeView.widthAnchor.constraint(equalToConstant: 64), imgeView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),imgeView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5)])
        imgeView.layer.cornerRadius = 6
        imgeView.clipsToBounds = true
        titleLabel.numberOfLines = 0
        self.contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([titleLabel.leadingAnchor.constraint(equalTo: imgeView.trailingAnchor, constant: 15), titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5)])
        titleLabel.sizeToFit()
        titleLabel.font = UIFont.init(descriptor: .preferredFontDescriptor(withTextStyle: .headline), size: 20)
        self.contentView.addSubview(descrpnLabel)
        descrpnLabel.numberOfLines = 0
        descrpnLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([descrpnLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor), descrpnLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor), descrpnLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),descrpnLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5)])
        descrpnLabel.sizeToFit()
        descrpnLabel.font = UIFont.init(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 16)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgeView.image = nil
    }
}
