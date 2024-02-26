//
//  BaseView.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 17.02.2024.
//

import UIKit
import RxSwift

class BaseView<ViewModel, ViewModelEventType>: UIViewController
where ViewModel: BaseViewModel<ViewModelEventType>, ViewModelEventType: ViewModelEvent {
    
    // MARK: -
    // MARK: Variables
    
    let viewModel: ViewModel
    let disposeBag = DisposeBag()
    
    // MARK: -
    // MARK: Init
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
        
        self.prepareBindings(bag: self.disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -
    //MARK: Overriding

    func prepareBindings(bag: DisposeBag) {
        
    }
}
