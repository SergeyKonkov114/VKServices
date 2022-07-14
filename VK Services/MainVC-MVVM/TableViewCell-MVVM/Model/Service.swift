//
//  Service.swift
//  VK Services
//
//  Created by Сергей Коньков on 14.07.2022.
//

import Foundation

struct VKServices: Decodable {
    let body: Body
    let status: Int
}

struct Body: Decodable {
    let services: [Service]
}

struct Service: Decodable {
    let name: String
    let description: String
    let link: String
    let iconUrl: String
}
