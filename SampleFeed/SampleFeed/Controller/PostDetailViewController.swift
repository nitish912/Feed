//
//  PostDetailViewController.swift
//  SampleFeed
//
//  Created by Nitish Kumar on 29/04/24.
//

import UIKit


import UIKit

class PostDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var post: Post?
    
    // MARK: - Outlets
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0 // Allow multiple lines
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(bodyLabel)
        
        // Adjusting constraints for vertical scrolling
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            bodyLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            bodyLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            bodyLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            bodyLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20) // Adjust this constraint
        ])

        guard let post = post else {
            // If post is not available, display an error message or handle accordingly
            titleLabel.text = "Post not found"
            bodyLabel.text = ""
            return
        }
        
        titleLabel.text = post.title ?? ""
        bodyLabel.text = post.body ?? ""
        
        // Set content size for vertical scrolling
        view.layoutIfNeeded()
        scrollView.contentSize = CGSize(width: scrollView.bounds.width, height:  titleLabel.frame.maxY + bodyLabel.frame.maxY + 40)
    }
}
