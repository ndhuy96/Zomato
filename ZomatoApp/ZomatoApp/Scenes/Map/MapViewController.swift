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
    }
    
    private func config() {
//        searchBarTextField.delegate = self
        searchBarTextField.leftImage = nil
//        mapView.isHidden = true
        hideKeyboardWhenTappedAround()
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

//extension MapViewController: UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if textField == searchBarTextField {
//            UIView.transition(with: backButton, duration: 0.2, options: .transitionCrossDissolve, animations: {
//                self.backButton.center.y += 4
//                self.backButton.alpha = 0.0
//            }, completion: { finished in
//                if finished {
//                    self.backButton.setImage(UIImage(named: "ic-search"), for: UIControl.State.normal)
//                    self.backButton.alpha = 1.0
//                    self.backButton.isUserInteractionEnabled = false
//                }
//            })
//        }
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if textField == searchBarTextField {
//            UIView.transition(with: backButton, duration: 0.2, options: .transitionCrossDissolve, animations: {
//                self.backButton.center.y -= 4
//                self.backButton.alpha = 0.0
//            }, completion: { finished in
//                if finished {
//                    self.backButton.setImage(UIImage(named: "ic-back-button"), for: UIControl.State.normal)
//                    self.backButton.alpha = 1.0
//                    self.backButton.isUserInteractionEnabled = true
//                }
//            })
//        }
//    }
//}

extension MapViewController: StoryboardSceneBased {
    static var sceneStoryboard = UIStoryboard.map
}
