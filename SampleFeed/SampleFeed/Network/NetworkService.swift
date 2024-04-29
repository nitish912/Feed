//
//  NetworkService.swift
//  SampleFeed
//
//  Created by Nitish Kumar on 29/04/24.
//

import Foundation
//Implement a network service to fetch data from the API endpoint with pagination support
class NetworkService {
    func fetchPosts(page: Int, completion: @escaping ([Post]?) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts?_page=\(page)")!
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Failed to fetch data:", error?.localizedDescription ?? "Unknown error")
                completion(nil)
                return
            }
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                completion(posts)
            } catch {
                print("Failed to decode data:", error.localizedDescription)
                completion(nil)
            }
        }.resume()
    }
}
