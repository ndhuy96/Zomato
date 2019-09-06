//
//  MainNavigator.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 9/4/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//


protocol MainNavigatable {
    func navigateToRestaurantsScreen(withCategoryId id: Int, api: CommonRepositoryImpl)
}

final class MainNavigator: MainNavigatable {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigateToRestaurantsScreen(withCategoryId id: Int, api: CommonRepositoryImpl) {
//        let restaurantNavigator = 
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
