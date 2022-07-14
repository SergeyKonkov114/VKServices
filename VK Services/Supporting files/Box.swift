//
//  Box.swift
//  VK Services
//
//  Created by Сергей Коньков on 14.07.2022.
//

import Foundation

class Box<T> {
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    init (_ value: T) {
        self.value = value
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }
}
