//
//  MainViewModel.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 9/4/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import RxCocoa
import RxSwift

final class MainViewModel: ViewModelType {
    struct Input {
        let ready: Driver<Void>
        let selected: Driver<Int>
    }
    
    struct Output {
        let loading: Driver<Bool>
        let results: Driver<HomeItemViewModel?>
        let selected: Driver<Void>
    }
    
    struct Dependencies {
        let api: CommonRepositoryImpl
        let navigator: MainNavigatable
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func transform(input: MainViewModel.Input) -> MainViewModel.Output {
        let activityIndicator = ActivityIndicator()
        let loading = activityIndicator.asDriver()

        let results = input.ready
            .asObservable()
            .flatMap {
                Observable.zip(self.dependencies.api.fetchCategories(),
                               self.dependencies.api.fetchCollectionsRestaurants(in: 281))
                .trackActivity(activityIndicator)
            }
        
         let mappedResult = results.map { item in
                return HomeItemViewModel(categories: item.0, collectionsRestaurants: item.1)
            }
            .asDriver(onErrorJustReturn: nil)
        
        let selected = input.selected
            .asObservable()
            .withLatestFrom(results) { ($0, $1) }
            .do(onNext: { [weak self] (index: Int, res: ([Categories], CollectionsRestaurants)) in
                guard let self = self else { return }
                
                let itemIndex = index
                let categories = res.0
                
                guard let id = categories[itemIndex].category?.id else { return }
                self.dependencies.navigator.navigateToRestaurantsScreen(withCategoryId: id, api: self.dependencies.api)
            })
            .map { _ in () }
            .asDriver(onErrorJustReturn: ())
        
        return Output(loading: loading, results: mappedResult, selected: selected)
    }
}

struct HomeItemViewModel {
    let categories: [Categories]
    let collectionsRestaurants: CollectionsRestaurants
}
