//
//  RedditPost.swift
//  RedditTest
//
//  Created by Magik on 21/5/23.
//

import Foundation

struct RedditData: Decodable {
    let data: [RedditPost]
}

struct RedditPost: Decodable {
    let title: String
    let user: String
    let date: Int
    let imageURL: String
    let comments: Int
    let subreddit: String
    let URL: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case user = "author"
        case date = "created"
        case imageURL = "thumbnail"
        case comments = "num_comments"
        case subreddit = "subreddit"
        case URL = "permalink"
    }
}
