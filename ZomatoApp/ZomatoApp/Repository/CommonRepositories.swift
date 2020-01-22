//
//  CommonRepositories.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 9/4/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import RxSwift

protocol CategoriesRepository {
    func fetchCategories() -> Observable<[Categories]>
    func fetchCollectionsRestaurants(in cityId: Int) -> Observable<CollectionsRestaurants>
    func fetchNearbyRestaurants(lat: Double, long: Double) -> Observable<NearbyRestaurantsResponse>
}

protocol ApiRepository: CategoriesRepository { }

final class CommonRepositoryImpl: ApiRepository {
    private var api: APIService?
    
    required init(api: APIService = APIService.shared) {
        self.api = api
    }
    
    func fetchCategories() -> Observable<[Categories]> {
        return Observable.create { observer in
            let input = FetchCategoriesRequest()
            let req = self.api?.request(input: input) { (object: CollectionCategories?, error) in
                if let object = object {
                    guard let categories = object.categories else { return }
                    observer.onNext(categories)
                    observer.onCompleted()
                } else if let error = error {
                    observer.onError(error)
                }
            }
            return Disposables.create {
                req?.cancel()
            }
        }
    }
    
    func fetchCollectionsRestaurants(in cityId: Int) -> Observable<CollectionsRestaurants> {
        return Observable.create { observer in
            let input = FetchCollectionsRestaurantsRequest(cityId: cityId)
            let req = self.api?.request(input: input) { (object: CollectionsRestaurants?, error) in
                if let collectionsRestaurants = object {
                    observer.onNext(collectionsRestaurants)
                    observer.onCompleted()
                } else if let error = error {
                    observer.onError(error)
                }
            }
            return Disposables.create {
                req?.cancel()
            }
        }
    }
    
    func fetchNearbyRestaurants(lat: Double, long: Double) -> Observable<NearbyRestaurantsResponse> {
        return Observable.create { observer in
            let input = FetchNearbyRestaurantsRequest(lat: lat, long: long)
            let req = self.api?.request(input: input) { (object: NearbyRestaurantsResponse?, error) in
                if let nearbyRestaurantsResponse = object {
                    observer.onNext(nearbyRestaurantsResponse)
                    observer.onCompleted()
                } else if let error = error {
                    observer.onError(error)
                }
            }
            return Disposables.create {
                req?.cancel()
            }
        }
    }
}
