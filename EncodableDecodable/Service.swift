//
//  Service.swift
//  EncodableDecodable
//
//  Created by Rozario on 12/12/17.
//  Copyright © 2017 VisionReached. All rights reserved.
//

import UIKit

class Service {
    static let sharedInstance = Service()
    private init() {}
    
    private let baseURL = "https://jsonplaceholder.typicode.com/"
    private let session = URLSession.shared
    
    func fetchUsers(completion: @escaping (_ users: [User], _ error: Error?)->Void) {
        guard let urlEndpoint = URL(string: "\(baseURL)users") else {return}
        session.dataTask(with: urlEndpoint) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion([], error)
                }
            }
            if let data = data {
                do {
                    let users = try JSONDecoder().decode([User].self, from: data)
                    DispatchQueue.main.async {
                        completion(users, nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion([], error)
                    }
                }
            }
        }.resume()
    }
}
