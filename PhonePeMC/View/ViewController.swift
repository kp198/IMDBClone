//
//  ViewController.swift
//  PhonePeMC
//
//  Created by Keerthika Priya G on 07/05/22.
//

import UIKit

class ViewController: UIViewController {

    let table = UITableView.init()
    let loader = UIActivityIndicatorView.init()
    var movies: [Movie]?
    let presenter = MoviePresenter.init()
//    var image: [UIImage?]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTable()
        setUpData()
        setLoader()
        self.navigationItem.title = "Movies"
    }

    
    func setLoader() {
        self.view.addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([loader.centerXAnchor.constraint(equalTo: self.view.centerXAnchor), loader.centerYAnchor.constraint(equalTo: self.view.centerYAnchor), loader.widthAnchor.constraint(equalToConstant: 40), loader.heightAnchor.constraint(equalToConstant: 40)])
        loader.startAnimating()
    }
    
    func setupTable() {
        self.view.addSubview(table)
        table.isHidden = true
        table.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([table.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10), table.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10), table.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), table.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)])
        table.delegate = self
        table.dataSource = self
        table.register(MovieCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setUpData() {
        presenter.retrieveMovies(completion: {[weak self]
            result, err in
            self?.movies = result?.results
//            self?.image = Array.init(repeating: nil, count: self?.movies?.count ?? 0)
            DispatchQueue.main.async {
                self?.table.reloadData()
                self?.loader.stopAnimating()
                self?.loader.isHidden = true
                self?.table.isHidden = false
            }
        })
    }
    
    func setImage(imgView: UIImageView?, movie: Movie, url: String, indexPath: IndexPath) {
        if let image = movie.image {
            imgView?.image = image
            return
        }
        presenter.retrieveImage(url: url) {
            data in
            DispatchQueue.main.async {
                if let data = data ,let img  = UIImage.init(data: data) {
                    imgView?.image = img
                    movie.image = img
//                    if self?.image != nil {
//                        if self!.image!.count > indexPath.row {
//                            self?.image!.insert(img, at: indexPath.row)
//                     }
//                    } else {
//                        self?.image = [img]
//                    }
                }
            }

        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "cell") as? MovieCell) ?? MovieCell.init()
        cell.titleLabel.text = movies?[indexPath.row].original_title
        cell.descrpnLabel.text = movies?[indexPath.row].overview
        if let url = movies?[indexPath.row].poster_path {
            setImage(imgView: cell.imgeView, movie: movies![indexPath.row], url: url, indexPath: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let movie = movies?[indexPath.row] {
            let movieVC = MovieDetailViewController.init(movieName: movie.original_title, rating: String(movie.vote_average), overView: movie.overview, popularity: String(movie.popularity), release: movie.release_date, image: movie.image/*image?.count ?? 0 > indexPath.row ? image?[indexPath.row] : nil*/, url: movie.poster_path)
            self.navigationController?.pushViewController(movieVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
}



