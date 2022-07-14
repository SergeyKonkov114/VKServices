//
//  NetworkDataFetcher.swift
//  VK Services
//
//  Created by Сергей Коньков on 14.07.2022.
//

import Foundation

class NetworkDataFetcher {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getVKServicesInfo(response: @escaping ([Service]?) -> ()) {
        let urlString = "https://publicstorage.hb.bizmrg.com/sirius/result.json"
        networkService.request(withUrlString: urlString) { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            } else {
                let decoded = self.parseJSON(type: VKServices.self, from: data)
                guard let decoded = decoded else {
                    response(nil)
                    return
                }
                response(decoded.body.services)
            }
        }
    }
    
    func getVKServiceImageData(urlString: String, response: @escaping (Data?) -> ()) {
        networkService.request(withUrlString: urlString) { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            } else {
                response(data)
            }
        }
    }
    
    private func parseJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy =  .convertFromSnakeCase
        do {
            guard let data = data else { return nil }
            let response = try decoder.decode(T.self, from: data)
            return response
        } catch {
            print("Error while unpacking data: \(error.localizedDescription)")
            return nil
        }
    }
}
