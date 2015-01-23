//
//  ContatosNoMapaViewController.h
//  ContatosIP67
//
//  Created by Joviane Jardim on 16/01/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ContatoDao.h"

@interface ContatosNoMapaViewController : UIViewController<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapa;
@property CLLocationManager *manager;
@property NSMutableArray *contatos;
@property ContatoDao *dao;

@end
