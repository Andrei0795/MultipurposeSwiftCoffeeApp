//
//  MapsViewController.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 09/06/2021.
//

import UIKit
import MapKit
import CoreLocation


class MapsViewController: UIViewController {
    enum SelectedButtonTag: Int {
        case First = 1
        case Second
        case Third
    }
    
    @IBOutlet private var mapView: MKMapView!
    @IBOutlet private var regionsView: UIView!
    
    @IBOutlet private var categoriesButton: UIButton!
    @IBOutlet private var organicButton: UIButton!
    @IBOutlet private var normalButton: UIButton!
    @IBOutlet private var favouriteButton: UIButton!
    @IBOutlet private var cancelButton: UIButton!

    @IBOutlet private var organicLabel: UILabel!
    @IBOutlet private var normalLabel: UILabel!
    @IBOutlet private var favouriteLabel: UILabel!
    @IBOutlet private var cancelLabel: UILabel!

    var buttonRotated: Bool = false
    var regionsActive: Bool = false
    var locationManager: CLLocationManager!
    var overlays = [MKOverlay]()
    var annotations = [PinView]()
    var renderers = [MKPolygonRenderer]()
    
    var viewModel: MapsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cafe Map"
        viewModel = MapsViewModel()
        configureMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.setupDatasource()
        configureMap()
    }
    
    private func configureMap() {
        regionsView.isHidden = true
        
        mapView.delegate = self
        mapView.removeAnnotations(annotations)
        annotations = viewModel.filteredAnnotationsDatasource
        mapView.addAnnotations(annotations)
        

        let latDelta:CLLocationDegrees = 0.025
        let lonDelta:CLLocationDegrees = 0.025
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let location = CLLocationCoordinate2D(latitude: 44.4361414, longitude: 26.1027202)
        let region = MKCoordinateRegion(center: location, span: span)

        mapView.setRegion(region, animated: false)
        
        normalButton.alpha = 0.0
        organicButton.alpha = 0.0
        favouriteButton.alpha = 0.0
        cancelButton.alpha = 0.0

        normalButton.center = categoriesButton.center
        organicButton.center = categoriesButton.center
        favouriteButton.center = categoriesButton.center
        cancelButton.center = categoriesButton.center

        normalLabel.alpha = 0.0
        organicLabel.alpha = 0.0
        favouriteLabel.alpha = 0.0
        cancelLabel.alpha = 0.0

        normalLabel.center.y = categoriesButton.center.y - 50
        organicLabel.center.y = categoriesButton.center.y - 100
        favouriteLabel.center.y = categoriesButton.center.y - 150
        cancelLabel.center.y = categoriesButton.center.y - 200

        normalLabel.center.x = categoriesButton.center.x - 50
        organicLabel.center.x = categoriesButton.center.x - 50
        favouriteLabel.center.x = categoriesButton.center.x - 50
        cancelLabel.center.x = categoriesButton.center.x - 50

        //Location track
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }


        mapView.showsUserLocation = true
        if let user = mapView.userLocation.location?.coordinate{
            mapView.setCenter(user, animated: true)
        }
    }
    
    func addOverlays() {
        var coord1 = [CLLocationCoordinate2D]()
        coord1.append(CLLocationCoordinate2D(latitude: 44.4426684, longitude: 26.1029369))
        coord1.append(CLLocationCoordinate2D(latitude: 44.4465288, longitude: 26.099375))
        coord1.append(CLLocationCoordinate2D(latitude: 44.4451501, longitude: 26.0913927))
        coord1.append(CLLocationCoordinate2D(latitude: 44.4409525, longitude: 26.0956842))
        
        var coord2 = [CLLocationCoordinate2D]()
        coord2.append(CLLocationCoordinate2D(latitude: 44.430172, longitude: 26.0966265))
        coord2.append(CLLocationCoordinate2D(latitude: 44.4345236, longitude: 26.0983861))
        coord2.append(CLLocationCoordinate2D(latitude: 44.4406213, longitude: 26.0955537))
        coord2.append(CLLocationCoordinate2D(latitude: 44.4397021, longitude: 26.0870564))
        coord2.append(CLLocationCoordinate2D(latitude: 44.4336349, longitude: 26.0898459))
        coord2.append(CLLocationCoordinate2D(latitude: 44.4302026, longitude: 26.0965836))

        var coord3 = [CLLocationCoordinate2D]()
        coord3.append(CLLocationCoordinate2D(latitude: 44.4344464, longitude: 26.0981998))
        coord3.append(CLLocationCoordinate2D(latitude: 44.4354269, longitude: 26.1024484))
        coord3.append(CLLocationCoordinate2D(latitude: 44.429206, longitude: 26.1036072))
        coord3.append(CLLocationCoordinate2D(latitude: 44.4301254, longitude: 26.0967407))
        
        addRegionOverlay(coordinates: coord1, type: 1)
        addRegionOverlay(coordinates: coord2, type: 2)
        addRegionOverlay(coordinates: coord3, type: 3)
    }
    
    func addRegionOverlay(coordinates: [CLLocationCoordinate2D], type: Int) {
        let poly = MKPolygon(coordinates: coordinates, count: coordinates.count)
        poly.title = String("\(type)")
        overlays.append(poly)
        let polyRenderer = MKPolygonRenderer(overlay: poly)
        
        switch type {
        case 1:
            polyRenderer.fillColor = .red
        case 2:
            polyRenderer.fillColor = .blue
        case 3:
            polyRenderer.fillColor = .green
        default:
            polyRenderer.fillColor = .black
        }
        
        polyRenderer.alpha = 0.25
        renderers.append(polyRenderer)
        
        mapView.addOverlay(poly)
    }
    
    @IBAction func tappedAdd(_ sender: Any) {
        rotate(layer: categoriesButton.layer)
        
        if buttonRotated {
            moveUp(button: normalButton, value: 50)
            moveUp(button: organicButton, value: 100)
            moveUp(button: favouriteButton, value: 150)
            moveUp(button: cancelButton, value: 200)
        } else {
            moveDown(button: normalButton, value: 50)
            moveDown(button: organicButton, value: 100)
            moveDown(button: favouriteButton, value: 150)
            moveDown(button: cancelButton, value: 200)
        }
    }
    
    @IBAction func tappedRegionsButton(_ sender: Any) {
        regionsActive = !regionsActive
        
        if !regionsActive {
            regionsView.isHidden = true
            mapView.removeOverlays(overlays)
        } else {
            regionsView.isHidden = false
            addOverlays()
        }
    }
    
    @IBAction func cancelFilters(_ sender: Any) {
        viewModel.cancelFilters()
        configureMap()
        tappedAdd(sender)
    }
    
    @IBAction func filtersTapped(sender: UIButton) {
        switch sender.tag {
            case SelectedButtonTag.First.rawValue:
                viewModel.filterDatasource(type: .normal)
                configureMap()
            case SelectedButtonTag.Second.rawValue:
                viewModel.filterDatasource(type: .organic)
                configureMap()
            case SelectedButtonTag.Third.rawValue:
                viewModel.filterDatasource(type: .favourite)
                configureMap()
            default:
                print("Should not reach here")
        }
        tappedAdd(sender)
    }
    
    func rotate(layer: CALayer) {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        let toValue = buttonRotated ? -Double.pi / 2 : Double.pi / 2
        rotation.toValue = NSNumber(value: toValue)
        rotation.duration = 0.25
        rotation.isCumulative = true
        rotation.repeatCount = 1
        layer.add(rotation, forKey: "rotationAnimation")
        buttonRotated = !buttonRotated
    }
    
    func moveUp(button: UIButton, value: CGFloat) {
        button.alpha = 1.0
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = categoriesButton.center.y
        animation.toValue = categoriesButton.center.y - value
        animation.duration = 0.25
        animation.beginTime = CACurrentMediaTime()
        animation.repeatCount = 1
        animation.autoreverses = false

        button.layer.add(animation, forKey: nil)
        button.center.y = categoriesButton.center.y - value
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.normalLabel.alpha = 1.0
            self.organicLabel.alpha = 1.0
            self.favouriteLabel.alpha = 1.0
            self.cancelLabel.alpha = 1.0
        }
    }
    
    func moveDown(button: UIButton, value: CGFloat) {
        normalLabel.alpha = 0.0
        organicLabel.alpha = 0.0
        favouriteLabel.alpha = 0.0
        cancelLabel.alpha = 0.0

        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = button.center.y
        animation.toValue = button.center.y + value
        animation.duration = 0.25
        animation.beginTime = CACurrentMediaTime()
        animation.repeatCount = 1
        animation.autoreverses = false

        button.layer.add(animation, forKey: nil)
        button.center.y = button.center.y + value
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            button.alpha = 0.0
        }
    }
}

extension MapsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        if let annotation = annotation as? PinView {
            let identifier = "identifier"
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            annotationView.image = annotation.image
            annotationView.canShowCallout = true
            annotationView.calloutOffset = CGPoint(x: -5, y: 5)
            annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            return annotationView
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("tapped")
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyOverlay = overlay as? MKPolygon {
            switch polyOverlay.title {
            case "1":
                return renderers[0]
            case "2":
                return renderers[1]
            case "3":
                return renderers[2]
            default:
                return MKOverlayRenderer.init()
            }
        }

        return MKOverlayRenderer.init()
    }
}

extension MapsViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}
