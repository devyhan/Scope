//
//  MapView.swift
//  Generic
//
//  Created by YHAN on 2022/07/21.
//  Copyright © 2022 tuist.io. All rights reserved.
//

import Combine
import ComposableArchitecture
import SwiftUI
import MapKit

// MARK: - UIViewControllerRepresentable

public struct MapView: UIViewControllerRepresentable {
  private let mapViewDidChangeVisibleRegion: (_ mapView: MKMapView) -> Void
  
  public init(
    mapViewDidChangeVisibleRegion: @escaping (_ mapView: MKMapView) -> Void
  ) {
    self.mapViewDidChangeVisibleRegion = mapViewDidChangeVisibleRegion
  }
  
  public func makeUIViewController(context: Context) -> some UIViewController {
    MapViewController(
      mapViewDidChangeVisibleRegion: mapViewDidChangeVisibleRegion
    )
  }
  
  public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    print("updateUIViewController")
  }
}

// MARK: - MapViewController Implementation

private final class MapViewController: UIViewController {
  private lazy var mapView = MKMapView()
  private var cancellables: Set<AnyCancellable> = []
  private let mapViewDidChangeVisibleRegion: (_ mapView: MKMapView) -> Void
  
  init(
    mapViewDidChangeVisibleRegion: @escaping (_ mapView: MKMapView) -> Void
  ) {
    self.mapViewDidChangeVisibleRegion = mapViewDidChangeVisibleRegion
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    mapView.delegate = self
    mapView.frame = UIScreen.main.bounds
    mapView.mapType = MKMapType.standard
    mapView.isZoomEnabled = true
    mapView.isScrollEnabled = true
    mapView.center = view.center
    view.addSubview(mapView)
  }
}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
  func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
    print("mapViewDidFinishLoadingMap")
  }
  
  func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
    mapViewDidChangeVisibleRegion(mapView)
  }
}
