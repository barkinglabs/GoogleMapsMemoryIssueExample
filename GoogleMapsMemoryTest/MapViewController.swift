//
//  MapViewController.swift
//  Fi
//
//  Created by Philip Hubert on 3/10/20.
//  Copyright © 2020 Fi. All rights reserved.
//

import GoogleMaps

class MapViewController: UIViewController {
    private var mapView: GMSMapView {
        guard let retainedMapView = currentMapViewInstance else {
            let generatedMapView = MapViewController.generateMapView()
            currentMapViewInstance = generatedMapView
            return generatedMapView
        }
        return retainedMapView
    }

    private var currentMapViewInstance: GMSMapView?

    private static func generateMapView() -> GMSMapView {
        let generatedView = GMSMapView()
        generatedView.mapType = .hybrid
        return generatedView
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addMapView()

        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForegroundNotification), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackgroundNotification), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }

    private func addMapView() {
        guard mapView.superview == nil else {
            return
        }

        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        let edgeConstraintAttributes: [NSLayoutConstraint.Attribute] = [.top, .left, .right, .bottom ]
        view.addConstraints(edgeConstraintAttributes.map { NSLayoutConstraint(
            item: mapView,
            attribute: $0,
            relatedBy: .equal,
            toItem: view,
            attribute: $0,
            multiplier: 1,
            constant: 0
        ) })

        view.layoutIfNeeded()
    }

    private func removeMapView() {
        currentMapViewInstance?.clear()
        currentMapViewInstance?.delegate = nil
        currentMapViewInstance?.removeFromSuperview()
        currentMapViewInstance = nil
    }

    // MARK: Notification Center

    @objc private func willEnterForegroundNotification(_: Notification) {
        addMapView()
    }

    @objc private func didEnterBackgroundNotification(_: Notification) {
        removeMapView()
    }
}
