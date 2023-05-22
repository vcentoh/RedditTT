//
//  APICaller.swift
//  RedditTest
//
//  Created by Magik on 21/5/23.
//

import Foundation
import Alamofire

let headers = [
    "X-RapidAPI-Key": "54858c203bmsh87e556e774b19c0p10d1e4jsn7a29f7b9550c",
    "X-RapidAPI-Host": "reddit3.p.rapidapi.com"
]

final class APICaller {
    static let shared = APICaller()
    static let search: String = "https://www.reddit.com/"
    
    func fetchData(subReddit: String = "r/all") -> [RedditPost] {
        var data: [RedditPost] = []
        let search = APICaller.search + subReddit
        
        AF.session.configuration.httpAdditionalHeaders = headers
        AF.request( URL(string: search)!  ).responseDecodable(of: RedditData.self) { (response) in
            data = response.value?.data ?? []
            print(response)
        }
        return data
    }
    
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    private func parse(jsonData: Data) -> [RedditPost] {
        do {
            let decodedData = try JSONDecoder().decode(RedditData.self,
                                                       from: jsonData)
            dump(decodedData)
            return decodedData.data
        } catch {
            print("decode error")
        }
        return []
    }
    
    func getMock() -> [RedditPost] {
        guard let data = self.readLocalFile(forName: "mock") else { return [] }
        return self.parse(jsonData: data)
    }
}
