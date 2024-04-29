//
//  PostModel.swift
//  SampleFeed
//
//  Created by Nitish Kumar on 29/04/24.
//

import Foundation
// Define a model for each item in the list
struct Post: Codable {
    let userId : Int?
    let id: Int?
    let title: String?
    let body: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        userId = try container.decodeIfPresent(Int.self, forKey: .userId)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        body = try container.decodeIfPresent(String.self, forKey: .body)
    }
}
