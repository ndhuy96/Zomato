//
//  MapViewController.swift
//  ZomatoApp
//
//  Created by nguyen.duc.huyb on 9/30/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import GoogleMaps
import RxSwift
import RxCocoa

final class MapViewController: UIViewController {

    @IBOutlet private weak var mapView: GMSMapView!
    @IBOutlet private weak var searchBarTextField: DesignableUITextField!
    @IBOutlet private weak var backButton: UIButton!
    
    private var lat = 21.0227788
    private var long = 105.8194112
    
    var viewModel: MapViewModel!
    private let disposeBag = DisposeBag()
    
    // CardView variables
    // Current visible state of the card
    var cardVisible = false
    
    // Variable determines the next state of the card expressing that the card starts and collapsed
    var nextState: CardState {
        return cardVisible ? .collapsed : .expanded
    }

    // Starting and end card heights will be determined later
    var startCardHeight: CGFloat = 0
    var endCardHeight: CGFloat = 0
    
    // Empty property animator array
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted: CGFloat = 0
    
    // CardViewController
    let restaurantsVC = RestaurantsViewController(nibName: "RestaurantsViewController", bundle: nil)
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMap()
        config()
        bindViewModel()
    }
    
    private func createMap() {
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 14)
        mapView.camera = camera
        
        // Creates a marker in the center of the map
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        marker.title = "Your position"
        marker.snippet = "Hanoi"
        marker.map = mapView
        
        // Hide CardView by swipping map
        mapView.settings.consumesGesturesInView = true
        
        for gestureRecognizer in mapView.gestureRecognizers! {
            gestureRecognizer.addTarget(self, action: #selector(dismissCardView(_:)))
        }
    }
    
    private func config() {
        searchBarTextField.leftImage = nil
        setupCardView()
    }
    
    private func bindViewModel() {
        let input = MapViewModel.Input(ready: rx.viewWillAppear.asDriver(),
                                       backTrigger: backButton.rx.tap.asDriver())
        
        let output = viewModel.transform(input: input)
        
        output.backTaps
            .drive()
            .disposed(by: disposeBag)
    }
}

extension MapViewController: CustomTransitionOriginator {
    var fromAnimatedSubviews: [UIView] {
        return [searchBarTextField, backButton]
    }
}

extension MapViewController: CustomTransitionDestination {
    var toAnimatedSubviews: [UIView] {
        return [searchBarTextField, backButton]
    }
}

extension MapViewController: StoryboardSceneBased {
    static var sceneStoryboard = UIStoryboard.map
}
