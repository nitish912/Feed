//
//  ViewController.swift
//  SampleFeed
//
//  Created by Nitish Kumar on 29/04/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var feedTableView: UITableView!
    
    // MARK: - Properties
       
       let postManager =  PostManager()
       let networkService = NetworkService()
       
 
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register UITableViewCell with the table view
        setupTableView()
        fetchPosts()
    }
    
    // MARK: - Setup
        
        private func setupTableView() {
            title = "Posts"
            feedTableView.register(UINib(nibName: "FeedTableCell", bundle: nil), forCellReuseIdentifier: "FeedTableCell")
            feedTableView.delegate = self
            feedTableView.dataSource = self
            feedTableView.prefetchDataSource = self
        }
        
        // MARK: - Data Fetching
        
        private func fetchPosts() {
            networkService.fetchPosts(page: postManager.currentPage) { [weak self] fetchedPosts in
                guard let fetchedPosts = fetchedPosts else { return }
                self?.postManager.posts.append(contentsOf: fetchedPosts)
                DispatchQueue.main.async {
                    self?.feedTableView.reloadData()
                }
            }
        }

}

//MARK: - Data source & Delegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postManager.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableCell", for: indexPath) as! FeedTableCell
        let post = postManager.posts[indexPath.row]
        cell.PostData = post
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           if let postDetailVC = navigationController?.topViewController as? PostDetailViewController {
               postDetailVC.post = postManager.posts[indexPath.row]
               navigationController?.popToViewController(postDetailVC, animated: true)
           } else {
               navigateToPostDetail(post: postManager.posts[indexPath.row])
           }
       }
       
       private func navigateToPostDetail(post: Post) {
           guard let postDetailVC = storyboard?.instantiateViewController(withIdentifier: "PostDetailViewController") as? PostDetailViewController else { return }
           postDetailVC.post = post
           navigationController?.pushViewController(postDetailVC, animated: true)
       }
}

//MARK: - prefetch Data Source
extension ViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let rowsToFetch = indexPaths.map { $0.row }
        if rowsToFetch.contains(postManager.posts.count - 1) {
            postManager.currentPage += 1
            fetchPosts()
        }
    }
}
