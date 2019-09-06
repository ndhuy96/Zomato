//
//  HomeView.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 9/4/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import RxSwift
import RxCocoa
import SkeletonView

final class HomeView: UIView {
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView! {
        didSet {
            categoriesCollectionView.register(UINib(nibName: String(describing: CategoryViewCell.self), bundle: nil),
                                              forCellWithReuseIdentifier: String(describing: CategoryViewCell.self))
            categoriesCollectionView.delegate = self
            categoriesCollectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var restaurantsCollectionView: UICollectionView! {
        didSet {
            restaurantsCollectionView.register(UINib(nibName: String(describing: CollectionRestaurantsCell.self), bundle: nil),
                                               forCellWithReuseIdentifier: String(describing: CollectionRestaurantsCell.self))
            restaurantsCollectionView.delegate = self
            restaurantsCollectionView.dataSource = self
        }
    }
    
    @IBOutlet private weak var moreButton: UIButton!
    @IBOutlet private weak var searchBarTextField: DesignableUITextField!
    @IBOutlet private weak var foodImageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var titleLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var foodImageViewHeightConstraint: NSLayoutConstraint!
    
    private var categories: [Categories]?
    private var collectionsRestaurants: CollectionsRestaurants?

    private let selectedIndexSubject = PublishSubject<Int>()
    var selectedIndex: Observable<Int> {
        return selectedIndexSubject.asObservable()
    }
    
    private let itemsPerRow: CGFloat = 2
    
    var scrollView: UIScrollView!
    private var originalHeight: CGFloat!
    private var originalTopConstraint: CGFloat!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        setupCollectionViewFlowLayout()
    }
    
    func reloadData() {
        categoriesCollectionView.reloadData()
        restaurantsCollectionView.reloadData()
    }
    
    func setDataSource(_ categories: [Categories], collectionsRestaurants: CollectionsRestaurants) {
        self.categories = categories
        self.collectionsRestaurants = collectionsRestaurants
    }
    
    private func setup() {
        Bundle.main.loadNibNamed(String(describing: HomeView.self), owner: self, options: nil)
        addSubview(contentView)
        
        // titleLabel Constraint Settings
        if UIDevice.current.screenType == .iPhone_XSMax
            || UIDevice.current.screenType == .iPhones_X_XS
            || UIDevice.current.screenType == .iPhone_XR {
            originalTopConstraint = 40
        } else {
            originalTopConstraint = 32
        }
        
        // Food Background Image's original Height Constraint
        originalHeight = self.bounds.height * 1/3
        foodImageViewHeightConstraint.constant = originalHeight
        
        // Title Label's Original Top Constraint
        titleLabelTopConstraint.constant = originalTopConstraint
        
        // SearchBar Settings
        searchBarTextField.dropShadow()
        
//        moreButton.rx.tap.do(onNext: { [weak self] in
//            guard let self = self else { return }
//
//        })
    }
    
    private func setupCollectionViewFlowLayout() {
        // Custom CategoriesCollectionViewFlowLayout
        let offset = UIScreen.main.bounds.width - 16
        
        let categoriesCollectionViewLayout = CustomCollectionViewFlowLayout(itemsPerPage: 4, offsetForFirstPage: offset)
        categoriesCollectionViewLayout.minimumLineSpacing = 16.0
        categoriesCollectionViewLayout.scrollDirection = .horizontal
        categoriesCollectionViewLayout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        
        categoriesCollectionView.collectionViewLayout = categoriesCollectionViewLayout
        categoriesCollectionView.decelerationRate = .fast
        
        // Custom RestaurantsCollectionViewFlowLayout
        let offset2 = UIScreen.main.bounds.width * 0.7 + 8.0
        
        let restaurantsCollectionViewLayout = CustomCollectionViewFlowLayout(itemsPerPage: 1, offsetForFirstPage: offset2)
        restaurantsCollectionViewLayout.minimumLineSpacing = 8.0
        restaurantsCollectionViewLayout.scrollDirection = .horizontal
        restaurantsCollectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        restaurantsCollectionView.collectionViewLayout = restaurantsCollectionViewLayout
        restaurantsCollectionView.decelerationRate = .fast
    }
}

extension HomeView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexSubject.onNext(indexPath.item)
    }
}

extension HomeView: SkeletonCollectionViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        if skeletonView == restaurantsCollectionView {
            return String(describing: CollectionRestaurantsCell.self)
        } else {
            return String(describing: CategoryViewCell.self)
        }
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoriesCollectionView {
            return categories?.count ?? 0
        } else if collectionView == restaurantsCollectionView {
            guard let numberOfItems = collectionsRestaurants?.collections.count else { return 0 }
            if numberOfItems <= 10 {
                return numberOfItems
            } else {
                return 10
            }
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoriesCollectionView {
            let cell: CategoryViewCell = collectionView.dequeueReusableCell(for: indexPath)
            guard let data = categories else { return UICollectionViewCell() }
            guard let categoryName = data[indexPath.row].category?.name else { return UICollectionViewCell() }
            cell.config(categoryName, cornerRadius: (collectionView.bounds.height - 32) / 4)
            return cell
        } else if collectionView == restaurantsCollectionView {
            let cell: CollectionRestaurantsCell = collectionView.dequeueReusableCell(for: indexPath)
            guard let data = collectionsRestaurants else { return UICollectionViewCell() }
            cell.configCollectionRestaurants(data.collections[indexPath.row].collection)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension HomeView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoriesCollectionView {
            let width = (collectionView.bounds.width - 48) / itemsPerRow
            let height = (collectionView.bounds.height - 32) / 2
            return CGSize(width: width, height: height)
        } else if collectionView == restaurantsCollectionView {
            let width = collectionView.bounds.width * 0.7
            let height = collectionView.bounds.height - 16
            return CGSize(width: width, height: height)
        } else {
            return CGSize.zero
        }
    }
}

extension HomeView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let defaultTop = CGFloat(0)
        var currentTop = defaultTop
        
        if scrollView == self.scrollView {
            if offset < 0 {
                currentTop = offset
                foodImageViewHeightConstraint.constant = originalHeight - offset / 2
                titleLabelTopConstraint.constant = originalTopConstraint - offset / 2
            } else {
                foodImageViewHeightConstraint.constant = originalHeight
                titleLabelTopConstraint.constant = originalTopConstraint
            }
            foodImageViewTopConstraint.constant = currentTop
        }
    }
}
