//
//  publisherModel.swift
//  RedditTest
//
//  Created by Magik on 22/5/23.
//

import Foundation
import Combine
import UIKit

class PublisherModel: ObservableObject {
    
    private var apiCaller: APICaller
    private var cancelableSet: Set<AnyCancellable> = []
    @Published var redditPost: [RedditPost] = []
    
    init() {
        apiCaller = APICaller()
    }
    
   private func loadPost() {
        apiCaller.fetchAllData().sink{ (dResponse) in
            if dResponse.error != nil {
                print(dResponse.error.debugDescription)
            } else {
                self.redditPost = dResponse.value?.results ?? []
            }
        }
        .store(in: &cancelableSet)
    }
    
   private func searchSubReddit(reddit: String) {
        apiCaller.fetchSubRedditData(reddit: reddit).sink{ (dResponse) in
            if dResponse.error != nil {
                print(dResponse.error.debugDescription)
            } else {
                self.redditPost = dResponse.value?.results ?? []
            }
        }
        .store(in: &cancelableSet)
    }
    
    public func searchReddit(reddit: String) -> [RedditPost] {
        self.searchSubReddit(reddit: reddit)
        return redditPost
    }
    
    public func getPost() -> [RedditPost] {
        self.loadPost()
        return redditPost
    }
}
