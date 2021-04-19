//
//  GistCommentViewController.swift
//  Gist
//
//  Created by Thiago Lourin on 26/03/21.
//  Copyright © 2021 Lourin. All rights reserved.
//

import UIKit

class GistCommentViewController: UIViewController {
        
    private var containerView = UIView()
    private var labelUser = UILabel()
    private var link = UILabel()
    private var labelCreatedAt = UILabel()
    private var textComment = UITextField()
    private var sendButton = UIButton()
    private var activityIndicator = UIActivityIndicatorView()
    
    internal var code: String?
    var viewModel: GistCommentViewModel?
            
    override func viewDidLoad() {
        viewModel = GistCommentViewModel()
        viewModel?.gistLoadDelegate = self
        
        view.backgroundColor = .clear
        containerView.backgroundColor = .white
        setupView()
        setupButton()
        setupCommentView()
        setupActivityIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let code = code else { return }
        viewModel?.fetchGistFrom(id: code)
        activityIndicator.hidesWhenStopped = true
    }
    
    private func setupButton() {
        sendButton.setTitle("Send comment", for: .normal)
        sendButton.setTitleColor(.white, for: .normal)
        sendButton.backgroundColor = .systemBlue
        sendButton.isUserInteractionEnabled = true
        sendButton.addTarget(self, action: #selector(didTapSend), for: .touchUpInside)
    }
    
    @objc func didTapSend(_ sender: UIButton) {
        guard let code = code, let comment = textComment.text else { return }
        setupActivityIndicator()
        
        viewModel?.sendComment(code, comment)
    }
    
    private func setupCommentView() {
        textComment.placeholder = "Insert your comment"
        textComment.backgroundColor = .clear
    }
    
    private func setupView() {
        view.addSubviews([containerView, activityIndicator], constraints: true)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.heightAnchor.constraint(equalToConstant: 60),
            activityIndicator.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        containerView.addSubviews([labelUser,
                     link,
                     labelCreatedAt,
                     textComment,
                     sendButton], constraints: true)
        
        NSLayoutConstraint.activate([            
            labelUser.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            labelUser.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            labelUser.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            link.topAnchor.constraint(equalTo: labelUser.bottomAnchor, constant: 8),
            link.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            link.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            labelCreatedAt.topAnchor.constraint(equalTo: link.bottomAnchor, constant: 8),
            labelCreatedAt.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            labelCreatedAt.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            textComment.topAnchor.constraint(equalTo: labelCreatedAt.bottomAnchor, constant: 8),
            textComment.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            textComment.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            textComment.heightAnchor.constraint(equalToConstant: 48),
            sendButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            sendButton.topAnchor.constraint(equalTo: textComment.bottomAnchor, constant: 16),
            sendButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            sendButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupTitle(_ id: String) {
        self.title = "Gist: \(id)"
    }
    
    private func setupActivityIndicator() {
        if activityIndicator.isAnimating {
            activityIndicator.stopAnimating()
            return
        }
        activityIndicator.startAnimating()
    }
}

extension GistCommentViewController: GistCommentViewModelDelegate {
            
    func didLoadGist() {
        guard let viewModel = viewModel, let gist = viewModel.gist else { return }
        
        labelUser.text = "User: \(gist.owner.login)"
        link.text = "Link: \(gist.html_url)"
        labelCreatedAt.text = "Created at: \(gist.created_at)"
        
        setupTitle(gist.id)
        setupActivityIndicator()
    }
    
    func errorLoadingGist() {
        setupActivityIndicator()
    }
    
    func didSendComment() {
        print("Comment successfull!")
        setupActivityIndicator()
    }
    
    func errorSendingComment(_ error: String) {
        print(error)
        setupActivityIndicator()
    }
}
