//
//  GistCommentViewController.swift
//  Gist
//
//  Created by Thiago Lourin on 26/03/21.
//  Copyright © 2021 Lourin. All rights reserved.
//

import UIKit

class GistCommentViewController: UIView {
        
    private var labelUser = UILabel()
    private var link = UILabel()
    private var labelCreatedAt = UILabel()
    private var textComment = UITextView()
    private var sendButton = UIButton()
    
    private func setupView() {
        addSubviews([labelUser,
                     link,
                     labelCreatedAt,
                     textComment,
                     sendButton], constraints: true)
        
        NSLayoutConstraint.activate([
            labelUser.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            labelUser.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            labelUser.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
            link.topAnchor.constraint(equalTo: labelUser.bottomAnchor, constant: 8),
            link.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            link.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
            labelCreatedAt.topAnchor.constraint(equalTo: link.bottomAnchor, constant: 8),
            labelCreatedAt.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            labelCreatedAt.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
            textComment.topAnchor.constraint(equalTo: labelCreatedAt.bottomAnchor, constant: 8),
            textComment.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textComment.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
            textComment.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
}
