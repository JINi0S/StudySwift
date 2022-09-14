//
//  FilterViewModel.swift
//  SearchDaumBlog
//
//  Created by 이진희 on 2022/09/14.
//

import RxSwift
import RxCocoa


struct FilterViewModel {
    let sortButtonTapped = PublishRelay<Void>()
    let shouldUpdateType: Observable<Void>
    
    init() {
        self.shouldUpdateType = sortButtonTapped
            .asObservable()
    }
}
