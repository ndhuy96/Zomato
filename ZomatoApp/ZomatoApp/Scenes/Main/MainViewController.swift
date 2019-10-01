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
    @IBOutlet private weak var locationButton: UIButton!
    @IBOutlet private weak var searchBarTextField: DesignableUITextField!
    @IBOutlet private weak var foodImageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var titleLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var foodImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var locationButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var searchBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var searchIconButton: UIButton!
    
    private var originalHeight: CGFloat!
    private var originalTopConstraint: CGFloat!
    
    var viewModel: MainViewModel!
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        bindViewModel()
        setupSkeletonView()
    }
       
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeView.restaurantsCollectionView.startSkeletonAnimation()
        homeView.categoriesCollectionView.startSkeletonAnimation()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupSkeletonView() {
        homeView.restaurantsCollectionView.isSkeletonable = true
        homeView.categoriesCollectionView.isSkeletonable = true
       
        homeView.restaurantsCollectionView.prepareSkeleton(completion: { done in
            self.homeView.restaurantsCollectionView.showAnimatedSkeleton()
        })

        homeView.categoriesCollectionView.prepareSkeleton(completion: { done in
            self.homeView.categoriesCollectionView.showAnimatedSkeleton()
        })
    }
    
    private func config() {
        hideKeyboardWhenTappedAround()
        scrollView.delegate = self
        
        // titleLabel Constraint Settings
        if UIDevice.current.screenType == .iPhone_XSMax_11ProMax
            || UIDevice.current.screenType == .iPhones_X_XS_11Pro
            || UIDevice.current.screenType == .iPhone_XR_11 {
            originalTopConstraint = 50
            originalHeight = UIScreen.main.bounds.height * 0.4
            locationButtonHeightConstraint.constant = 40
            searchBarHeightConstraint.constant = 46
        } else {
            originalTopConstraint = 20
            originalHeight = UIScreen.main.bounds.height * 0.35
            locationButtonHeightConstraint.constant = 32
            searchBarHeightConstraint.constant = 40
        }
        
        // Food Background Image's original Height Constraint
        foodImageViewHeightConstraint.constant = originalHeight
        
        // Title Label's Original Top Constraint
        titleLabelTopConstraint.constant = originalTopConstraint
        
        // SearchBar Settings
        searchBarTextField.leftImage = nil
    }
    
    private func bindViewModel() {
        let input = MainViewModel.Input(ready: rx.viewWillAppear.asDriver(),
                                        selected: homeView.selectedIndex.asDriver(onErrorJustReturn: 0),
                                        locationTrigger: locationButton.rx.tap.asDriver())
        
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
        
        output.locationTaps
            .drive()
            .disposed(by: disposeBag)
        
        output.error
            .drive(onNext: { [weak self] error in
                if let err = error as? BaseError,
                    let self = self {
                    self.showAlert(message: err.errorMessage!)
                }
            })
        .disposed(by: disposeBag)
    }
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let defaultTop = CGFloat(0)
        var currentTop = defaultTop
        
        if scrollView == self.scrollView {
            if offset < 0 {
                currentTop = offset
                if UIDevice.current.screenType == .iPhone_XSMax_11ProMax
                || UIDevice.current.screenType == .iPhones_X_XS_11Pro
                || UIDevice.current.screenType == .iPhone_XR_11 {
                    foodImageViewHeightConstraint.constant = originalHeight - offset / 2
                    titleLabelTopConstraint.constant = originalTopConstraint - offset / 2
                } else {
                    foodImageViewHeightConstraint.constant = originalHeight - offset
                    titleLabelTopConstraint.constant = originalTopConstraint - offset
                }
            } else {
                foodImageViewHeightConstraint.constant = originalHeight
                titleLabelTopConstraint.constant = originalTopConstraint
            }
            foodImageViewTopConstraint.constant = currentTop
        }
    }
}

extension MainViewController: CustomTransitionOriginator {
    var fromAnimatedSubviews: [UIView] {
        return [searchBarTextField, searchIconButton]
    }
}

extension MainViewController: CustomTransitionDestination {
    var toAnimatedSubviews: [UIView] {
        return [searchBarTextField, searchIconButton]
    }
}

extension MainViewController: StoryboardSceneBased {
    static var sceneStoryboard = UIStoryboard.main
}
