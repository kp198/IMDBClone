//
//  MoviePresenter.swift
//  PhonePeMC
//
//  Created by Keerthika Priya G on 07/05/22.
//

import Foundation


class MoviePresenter {
    func retrieveMovies(completion: @escaping(Results?,Error?)->Void) {
        let network = NetworkRequest.init()
        network.sendRequest(urlString: "/movie/popular", completion: completion)
    }
    
    func retrieveImage(url: String, completion: @escaping(Data?)->Void) {
        
        let network = NetworkRequest.init()
        network.sendRequest(urlString: "https://image.tmdb.org/t/p/w500"+url, completion: {
            data , err in
            if data != nil {
                completion(data)
            }
        })
    }
}
