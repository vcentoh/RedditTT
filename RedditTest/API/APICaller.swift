//
//  APICaller.swift
//  RedditTest
//
//  Created by Magik on 21/5/23.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    struct Constans {
        static let redditURL = URL(string: "redditapi.p.rapidapi.com")
        static let apiKey: String = "54858c203bmsh87e556e774b19c0p10d1e4jsn7a29f7b9550c"
    }
    
    public func fecthRedditData(subReddit: String? = "", completion: @escaping (Result<[RedditPost], Error>) -> Void) {
        guard let url = Constans.redditURL else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                print(error)
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(RedditData.self, from: data)
                    print(result.data.count)
                }
                catch {
                    completion(.failure(error))
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    var mockData: [String] {
        return [ "1","2","Bananas","Pasas"]
    }
    
}
