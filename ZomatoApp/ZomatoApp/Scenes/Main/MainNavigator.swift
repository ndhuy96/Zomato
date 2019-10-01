//
//  MainNavigator.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 9/4/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//


protocol MainNavigatable {
    func navigateToRestaurantsScreen(withCategoryId id: Int, api: CommonRepositoryImpl)
    func navigateToMapScreen()
}

final class MainNavigator: MainNavigatable {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigateToRestaurantsScreen(withCategoryId id: Int, api: CommonRepositoryImpl) {
    }
    
    func navigateToMapScreen() {
        let mapDetailNavigator = MapViewNavigator(navigationController: navigationController)
        let mapViewModel = MapViewModel(dependencies: MapViewModel.Dependencies(navigator: mapDetailNavigator))
        
        let mapViewController = UIStoryboard.map.mapViewController
        mapViewController.viewModel = mapViewModel
//        mapViewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(mapViewController, animated: true)
    }
    
//    func navigateToMovieDetailScreen(withMovieId id: Int, api: TMDBApiProvider) {
//        let movieDetailNavigator = MovieDetailNavigator(navigationController: navigationController)
//        let movieDetailViewModel = MovieDetailViewModel(dependencies: MovieDetailViewModel.Dependencies(id: id,
//                                                                                                        api: api,
//                                                                                                        navigator: movieDetailNavigator))
//        let movieDetailViewController = UIStoryboard.main.movieDetailViewController
//        movieDetailViewController.viewModel = movieDetailViewModel
//
//        navigationController.show(movieDetailViewController, sender: nil)
//    }
}
