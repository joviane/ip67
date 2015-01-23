//
//  GerenciadorDeAcoes.h
//  ContatosIP67
//
//  Created by Joviane Jardim on 15/01/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Contato.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface GerenciadorDeAcoes : NSObject<UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@property Contato *contato;
@property UIViewController* controller;
-(id)initWithContato:(Contato *)contato;
-(void)acoesNaView:(UIView *)view doController:(UIViewController *)controller;

@end
