//
//  NetworkService.swift
//  VK Services
//
//  Created by Сергей Коньков on 14.07.2022.
//

import Foundation

class NetworkService {
    func request(withUrlString urlString: String, completion: @escaping (Data?, Error?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> ()) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            completion(data, error)
        }
    }
}
