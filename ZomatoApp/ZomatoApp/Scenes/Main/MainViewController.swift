//
//  ViewController.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 8/30/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import RxSwift
import RxCocoa
import SkeletonView

final class MainViewController: UIViewController {
    @IBOutlet private weak var homeView: HomeView!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    var viewModel: MainViewModel!
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        homeView.restaurantsCollectionView.isSkeletonable = true
        homeView.categoriesCollectionView.isSkeletonable = true
        
        homeView.restaurantsCollectionView.prepareSkeleton(completion: { done in
            self.homeView.restaurantsCollectionView.showAnimatedSkeleton()
        })
        
        homeView.categoriesCollectionView.prepareSkeleton(completion: { done in
            self.homeView.categoriesCollectionView.showAnimatedSkeleton()
        })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func config() {
        hideKeyboardWhenTappedAround()
        homeView.scrollView = scrollView
        scrollView.delegate = homeView
    }
    
    private func bindViewModel() {
        let input = MainViewModel.Input(ready: rx.viewWillAppear.asDriver(),
                                        selected: homeView.selectedIndex.asDriver(onErrorJustReturn: 0))
        
        let output = viewModel.transform(input: input)
        
        output.loading
            .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
        
        output.loading
            .drive(onNext: { [weak self] loading in
                guard let self = self else { return }
                if !loading {
                    self.homeView.restaurantsCollectionView.hideSkeleton()
                    self.homeView.categoriesCollectionView.hideSkeleton()
                }
            })
            .disposed(by: disposeBag)
        
        
        output.results
            .drive(onNext: { [weak self] data in
                guard let self = self,
                    let data = data else { return }
                self.homeView.setDataSource(data.categories, collectionsRestaurants: data.collectionsRestaurants)
                self.homeView.reloadData()
            })
            .disposed(by: disposeBag)
        
        output.selected
            .drive()
            .disposed(by: disposeBag)
    }

    @IBAction func handleLogoutButtonTapped(_ sender: Any) {
//        UserDefaults.standard.set(false, forKey: "LOGGED_IN")
        App.shared.swipeBackToLogin()
    }
}

extension MainViewController: StoryboardSceneBased {
    static var sceneStoryboard = UIStoryboard.main
}
