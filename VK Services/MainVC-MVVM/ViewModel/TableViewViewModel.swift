//
//  TableViewViewModel.swift
//  VK Services
//
//  Created by Сергей Коньков on 14.07.2022.
//

import Foundation

class TableViewViewModel {
    
    func fetchServices(completion: @escaping ([Service]?) -> ()) {
        fetcher.getVKServicesInfo(response: completion)
    }
    
    func fetchImageData(urlString: String, completion: @escaping (Data?) -> ()) {
        fetcher.getVKServiceImageData(urlString: urlString, response: completion)
    }
    
    func numberOfRows() -> Int {
        let defaultNumberOfCells = 9
        return services?.count ?? defaultNumberOfCells
    }
    
    func tableViewCellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModel? {
        guard let services = services else { return nil }
        if let images = dataImages.value,
           images.count == services.count {
            return TableViewCellViewModel(service: services[indexPath.row],
                                          imageData: images[indexPath.row])
        } else {
            return TableViewCellViewModel(service: services[indexPath.row],
                                          imageData: nil)
        }
    }
    
    func getServiceUrl(forIndexPath indexPath: IndexPath) -> URL? {
        guard let services = services else { return nil}
        let urlString = services[indexPath.row].link
        return URL(string: urlString)
    }
    
    private let fetcher = NetworkDataFetcher(networkService: NetworkService())
    
    var services: [Service]? {
        willSet(services) {
            guard let services = services else { return }
            var dataImages: [Data?] = []
            //print(services.count)
            for service in services {
                fetchImageData(urlString: service.iconUrl) { data in
                    dataImages.append(data)
                    if dataImages.count == services.count {
                        self.dataImages.value = dataImages
                    }
                }
            }
        }
    }
    
    var dataImages: Box<[Data?]?> = Box(nil)
}
