//
//  BaseViewModel.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 17.02.2024.
//

import Foundation

protocol ViewModelEvent { }

class BaseViewModel<Event: ViewModelEvent> {
    
    public var outputEvents: ((Event) -> ())?
}

