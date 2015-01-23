//
//  AppDelegate.h
//  ContatosIP67
//
//  Created by Joviane Jardim on 22/12/14.
//  Copyright (c) 2014 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ContatoDao.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong) ContatoDao *dao;

@end

