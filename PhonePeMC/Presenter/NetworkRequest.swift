//
//  NetworkRequest.swift
//  PhonePeMC
//
//  Created by Keerthika Priya G on 07/05/22.
//

import Foundation


class NetworkRequest {
    let apiKey = "38a73d59546aa378980a88b645f487fc"
    let baseUrl = "https://api.themoviedb.org/3"
    
    func sendRequest <T:Codable>(urlString: String, params: [String:String]? = nil, completion: @escaping(T?,Error?) -> Void) {
        var urlComp = URLComponents.init(string: baseUrl + urlString)
        urlComp?.queryItems = [URLQueryItem.init(name: "api_key", value: apiKey)]
        for i in params ?? [:] {
            urlComp?.queryItems?.append(URLQueryItem.init(name: i.key, value: i.value))
        }
        guard let url = urlComp?.url else {return}
        URLSession.shared.dataTask(with: url, completionHandler: {
            data, resp, err in
            if data == nil || ((resp as? HTTPURLResponse)?.statusCode ?? 0) != 200 || err != nil {
                completion(nil, NSError.init(domain: "Err", code: 500))
                return
            }
            if let decoded = try? JSONDecoder.init().decode(T.self, from: data!) {
                completion(decoded,nil)
            } else {
                completion(nil, NSError.init(domain: "ParsingIssue", code: 500))
            }
            
        }).resume()
            
    }
    
    func sendRequest(urlString: String, params: [String:String]? = nil, completion: @escaping(Data?,Error?) -> Void) {
        var urlComp = URLComponents.init(string: urlString)
        for i in params ?? [:] {
            urlComp?.queryItems?.append(URLQueryItem.init(name: i.key, value: i.value))
        }
        guard let url = urlComp?.url else {
            
            return}
        URLSession.shared.dataTask(with: url, completionHandler: {
            data, resp, err in
            if data == nil || ((resp as? HTTPURLResponse)?.statusCode ?? 0) != 200 || err != nil {
                completion(nil, NSError.init(domain: "Err", code: 500))
                return
            }
            completion(data!, nil)
            
        }).resume()
            
    }
    
}


