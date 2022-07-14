//
//  TableViewCellViewModel.swift
//  VK Services
//
//  Created by Сергей Коньков on 14.07.2022.
//

import Foundation

class TableViewCellViewModel {
    private let service: Service
    private let imageData: Data?
    var serviceName: String {
        return service.name
    }
    var serviceDescription: String {
        return service.description
    }
    var serviceImageData: Data? {
        return imageData
    }
    var serviceUrl: URL? {
        return URL(string: service.link)
    }
    
    init(service: Service, imageData: Data?) {
        self.service = service
        self.imageData = imageData
    }
}
