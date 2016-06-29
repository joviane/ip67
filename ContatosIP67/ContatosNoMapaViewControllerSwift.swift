//
//  ContatosNoMapaViewControllerSwift.swift
//  ContatosIP67
//
//  Created by Joviane Jardim on 16/02/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ContatosNoMapaViewControllerSwift: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapa: MKMapView!
    var dao : ContatoDao!
    var contatos : NSMutableArray
    let manager : CLLocationManager = CLLocationManager()

    required init(coder aDecoder: NSCoder) {
        self.dao = ContatoDao.contatoDaoInstance() as! ContatoDao
        self.contatos = dao.contatos
        
        super.init(nibName: "ContatosNoMapaViewController", bundle: nil)
        self.tabBarItem = UITabBarItem(title: "Mapa Swift", image: UIImage(named: "mapa-contatos.png"), tag: 0)
        self.navigationItem.title = "Mapa Swift"
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let botao = MKUserTrackingBarButtonItem(mapView: self.mapa)
        self.navigationItem.rightBarButtonItem = botao
        
        self.manager.requestWhenInUseAuthorization()
        self.mapa.delegate = self
        
//        self.mapa.region = MKCoordinateRegionMake(self.manager.location.coordinate, MKCoordinateSpan(latitudeDelta: 2000, longitudeDelta: 2000));
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if(annotation.isKindOfClass(MKUserLocation)){
            return nil
        }
        let identificador = "Pino"
        var pino = self.mapa.dequeueReusableAnnotationViewWithIdentifier(identificador) as? MKPinAnnotationView
        if((pino) != nil){
            pino!.annotation = annotation
        } else {
            pino = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identificador)
        }
        let contato = annotation as! Contato
        pino!.pinColor = MKPinAnnotationColor.Red
        pino!.canShowCallout = true
        
        if((contato.foto) != nil) {
            let imagem = UIImageView(frame: CGRectMake(0.0, 0.0, 32.0, 32.0))
            imagem.image = contato.foto
            pino!.leftCalloutAccessoryView = imagem
        }
        
        return pino
    }
    
    override func viewWillAppear(animated: Bool) {
        self.mapa.addAnnotations(self.contatos as! [MKAnnotation])
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.mapa.removeAnnotations(self.contatos as! [MKAnnotation])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
