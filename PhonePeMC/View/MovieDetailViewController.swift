//
//  MovieDetailViewController.swift
//  PhonePeMC
//
//  Created by Keerthika Priya G on 07/05/22.
//

import Foundation
import UIKit



class MovieDetailViewController: UIViewController {
    let imageView = UIImageView.init()
    let ratingLabel = UILabel.init()
    let releaseDateLabel = UILabel.init()
    let popularityLabel = UILabel.init()
    let overViewLabel = UILabel.init()
    var presenter: MoviePresenter?
    
    enum LabelType {
        case rating
        case release
        case popularity
        case overView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    init(rating: String, overView: String,popularity: String, release: String, image: UIImage?, url: String?) {
        imageView.image = image
        super.init(nibName: nil, bundle: nil)
        if image == nil {
            retrieveImage(url: url)
        }
        releaseDateLabel.attributedText = setAttributedTitle(text: release, type: .release)
        overViewLabel.attributedText = setAttributedTitle(text: overView, type: .overView)
        ratingLabel.attributedText = setAttributedTitle(text: rating, type: .rating)
        popularityLabel.attributedText = setAttributedTitle(text: popularity, type: .popularity)
        self.view.backgroundColor = .white
    }
    
    func setAttributedTitle(text: String, type: LabelType) -> NSMutableAttributedString {
        var mutableStr = NSMutableAttributedString.init()
        switch type {
        case .rating:
            
            mutableStr.append(NSAttributedString.init(string: "Rating", attributes: [.font: UIFont.init(descriptor: .preferredFontDescriptor(withTextStyle: .headline), size: 16)]))
            mutableStr.append(NSAttributedString.init(string: "\n\u{2726} "+text, attributes:[.font: UIFont.init(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 14)]))
        case .release:
            mutableStr.append(NSAttributedString.init(string: "Release Date", attributes: [.font: UIFont.init(descriptor: .preferredFontDescriptor(withTextStyle: .headline), size: 16)]))
            mutableStr.append(NSAttributedString.init(string: "\n"+text, attributes:[.font: UIFont.init(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 14)]))
            
        case .popularity:
            mutableStr.append(NSAttributedString.init(string: "Popularity", attributes: [.font: UIFont.init(descriptor: .preferredFontDescriptor(withTextStyle: .headline), size: 16)]))
            mutableStr.append(NSAttributedString.init(string: "\n\u{2665} "+text, attributes:[.font: UIFont.init(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 14)]))
        case .overView:
            mutableStr.append(NSAttributedString.init(string: "Overview", attributes: [.font: UIFont.init(descriptor: .preferredFontDescriptor(withTextStyle: .headline), size: 16)]))
            mutableStr.append(NSAttributedString.init(string: "\n"+text, attributes:[.font: UIFont.init(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 14)]))
        }
        return mutableStr
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4), imageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4), imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20), imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40)])
        imageView.layer.cornerRadius = 6
        self.view.addSubview(releaseDateLabel)
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([releaseDateLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20), releaseDateLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20), releaseDateLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 20)])
        releaseDateLabel.numberOfLines = 2
        
        self.view.addSubview(ratingLabel)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ratingLabel.leadingAnchor.constraint(equalTo: releaseDateLabel.leadingAnchor), ratingLabel.trailingAnchor.constraint(equalTo: releaseDateLabel.trailingAnchor), ratingLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 20)])
        ratingLabel.numberOfLines = 2
        
        self.view.addSubview(popularityLabel)
        popularityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([popularityLabel.leadingAnchor.constraint(equalTo: releaseDateLabel.leadingAnchor), popularityLabel.trailingAnchor.constraint(equalTo: releaseDateLabel.trailingAnchor), popularityLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 20)])
        popularityLabel.numberOfLines = 2
        
//
        self.view.addSubview(overViewLabel)
        overViewLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([overViewLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 20), overViewLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20), overViewLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40), overViewLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)])
        overViewLabel.numberOfLines = 0
    }
    
    func retrieveImage(url: String?) {
        guard let url = url else {return}
            presenter?.retrieveImage(url: url) { [weak self]
                data in
                DispatchQueue.main.async {
                    if let data = data ,let img  = UIImage.init(data: data) {
                        self?.imageView.image = img
            }
        }
    }
  }
}
