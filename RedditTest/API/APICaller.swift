//
//  APICaller.swift
//  RedditTest
//
//  Created by Magik on 21/5/23.
//

import Foundation
import Alamofire
import ObjectMapper
import Combine

let apiHeaders: HTTPHeaders = [
    "X-RapidAPI-Key": "54858c203bmsh87e556e774b19c0p10d1e4jsn7a29f7b9550c",
    "X-RapidAPI-Host": "reddit3.p.rapidapi.com"
]

let apiUrl = URL(string: "https://reddit3.p.rapidapi.com/subreddit")

class APICaller {
    static let shared = APICaller()
    private let search: String = "https://www.reddit.com/r/all"
    
}

extension APICaller: ApiServiceProtocol {
    func fetchAllData() -> AnyPublisher<DataResponse<RedditData<RedditPost>, APIRestError>, Never> {
        guard let url = apiUrl else {
            return emptyPublisher(error: ConfigError(code: 555, message: "No url Defined"))
        }
        
        return AF.request(url, method: .get, parameters: search, headers: apiHeaders)
            .proccessResponse(type: RedditData<RedditPost>.self)
    }
    
    func fetchSubRedditData(reddit: String) -> AnyPublisher<Alamofire.DataResponse<RedditData<RedditPost>, APIRestError>, Never> {
        guard let url = apiUrl else {
            return emptyPublisher(error: ConfigError(code: 555, message: "No url Defined"))
        }
        
        return AF.request(url, method: .get, parameters: reddit, headers: apiHeaders)
            .proccessResponse(type: RedditData<RedditPost>.self)
    }
    
    private func emptyPublisher<T: Codable>(error:  ConfigError) -> AnyPublisher<DataResponse<T, APIRestError>, Never> {
        return Just<DataResponse<T, APIRestError>> (
            DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: .failure(APIRestError(error: error, serverError: nil)))
        ).eraseToAnyPublisher()
    }
}

extension DataRequest {
    func proccessResponse<T: Codable>(type: T.Type) -> AnyPublisher<DataResponse<T, APIRestError>, Never>{
        validate()
            .publishDecodable(type: type.self)
            .map { response in
                response.mapError { error  in
                    let sError = response.data.flatMap { try? JSONDecoder().decode(ServerError.self, from: $0) }
                    return APIRestError(error: error, serverError: sError)
                }
            }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
