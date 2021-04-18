//
//  GistCommentViewController.swift
//  Gist
//
//  Created by Thiago Lourin on 26/03/21.
//  Copyright © 2021 Lourin. All rights reserved.
//

import UIKit

class GistCommentViewController: UIViewController {
        
    private var labelUser = UILabel()
    private var link = UILabel()
    private var labelCreatedAt = UILabel()
    private var textComment = UITextView()
    private var sendButton = UIButton()
    
    override func viewDidLoad() {
        
    }
    
    private func setupView() {
        view.addSubviews([labelUser,
                     link,
                     labelCreatedAt,
                     textComment,
                     sendButton], constraints: true)
        
        NSLayoutConstraint.activate([
            labelUser.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            labelUser.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            labelUser.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
            link.topAnchor.constraint(equalTo: labelUser.bottomAnchor, constant: 8),
            link.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            link.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
            labelCreatedAt.topAnchor.constraint(equalTo: link.bottomAnchor, constant: 8),
            labelCreatedAt.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            labelCreatedAt.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
            textComment.topAnchor.constraint(equalTo: labelCreatedAt.bottomAnchor, constant: 8),
            textComment.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textComment.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
            textComment.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
}
