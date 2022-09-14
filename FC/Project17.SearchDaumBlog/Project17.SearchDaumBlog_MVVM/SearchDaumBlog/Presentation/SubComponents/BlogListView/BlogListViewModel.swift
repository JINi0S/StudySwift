//
//  BlogListViewModel.swift
//  SearchDaumBlog
//
//  Created by 이진희 on 2022/09/14.
//

import RxSwift
import RxCocoa

struct BlogListViewModel {
    let filterViewModel = FilterViewModel()
    
    let blogListCellData = PublishSubject<[BlogListCellData]>()
    let cellData: Driver<[BlogListCellData]>
    
    init() {
        self.cellData = blogListCellData
            .asDriver(onErrorJustReturn: [])
    }
}
