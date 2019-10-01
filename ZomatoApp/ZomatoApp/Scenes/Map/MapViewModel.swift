//
//  MapViewModel.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 10/1/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import RxCocoa
import RxSwift

final class MapViewModel: ViewModelType {
    struct Input {
        let ready: Driver<Void>
        let backTrigger: Driver<Void>
    }
    
    struct Output {
        let loading: Driver<Bool>
//        let results: Driver<MapItemViewModel>
//        let selected: Driver<Void>
        let backTaps: Driver<Void>
    }
    
    struct Dependencies {
        let navigator: MapViewNavigatable
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func transform(input: MapViewModel.Input) -> MapViewModel.Output {
        let activityIndicator = ActivityIndicator()
        let loading = activityIndicator.asDriver()

        let backTaps = input.backTrigger
            .do(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.dependencies.navigator.goBack()
            })
        return Output(loading: loading, backTaps: backTaps)
    }
}
