//
//  RedditPost.swift
//  RedditTest
//
//  Created by Magik on 21/5/23.
//

import Foundation
import ObjectMapper

struct RedditData<T:Codable>: Codable  {
    var page: Int
    var results: [T]
}

struct RedditPost: Codable {
    
    var title: String = ""
    var user: String = ""
    var date: Int = 0
    var thumbnail: String = ""
    var comments: Int = 0
    var subreddit: String = ""
    var URL: String = ""
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case user = "author"
        case date = "created"
        case thumbnail = "thumbnail"
        case comments = "num_comments"
        case subreddit = "subreddit"
        case URL = "permalink"
    }
}
