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
    let id: Int
    let title: String
    let autor: String
    let date: String
    let imageURL: String
    let nComments: Int
    let subreddit: String
}
