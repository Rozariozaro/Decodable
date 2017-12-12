//
//  ViewController.swift
//  EncodableDecodable
//
//  Created by Rozario on 12/12/17.
//  Copyright © 2017 VisionReached. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var table: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tv.delegate = self
        tv.dataSource = self
        tv.showsVerticalScrollIndicator = false
        tv.showsHorizontalScrollIndicator = false
        tv.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tv.separatorStyle = .singleLine
        return tv
    }()
    
    var users: [User] = Array() {
        didSet{
            table.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        Service.sharedInstance.fetchUsers { [weak self] (users, error) in
            guard let strongSelf = self else {return}
            if let error = error {
                print(error.localizedDescription)
                return
            }
            strongSelf.users = users
        }
    }
    
    fileprivate func setupViews() {
        self.navigationItem.title = "Users"
        view.addSubview(table)
        NSLayoutConstraint.activate([
            table.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            table.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: 0),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)])
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellID")
        cell.selectionStyle = .none
        let user = users[indexPath.row]
        cell.textLabel?.text = user.username
        cell.detailTextLabel?.text = user.company.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

