//
//  APIService.swift
//  RedditTest
//
//  Created by Magik on 22/5/23.
//

import Foundation
import Combine
import Alamofire

struct APIRestError: Error {
    let error: Error
    let serverError: ServerError?
}

struct ServerError: Codable, Error {
    var status: String
    var message: String
}

struct ConfigError: Error {
    var code: Int
    var message: String
}

protocol ApiServiceProtocol {
    func fetchAllData() -> AnyPublisher<DataResponse<RedditData<RedditPost>, APIRestError>, Never>
    func fetchSubRedditData(reddit: String) -> AnyPublisher<DataResponse<RedditData<RedditPost>, APIRestError>, Never>
}
