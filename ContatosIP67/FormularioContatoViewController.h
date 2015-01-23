//
//  ViewController.h
//  ContatosIP67
//
//  Created by Joviane Jardim on 22/12/14.
//  Copyright (c) 2014 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contato.h"
#import "ContatoDao.h"
#import <CoreLocation/CoreLocation.h>

@protocol FormularioContatoViewControllerDelegate <NSObject>

- (void)contatoAtualizado:(Contato *)contato;
- (void)contatoAdicionado:(Contato *)contato;

@end

@interface FormularioContatoViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nome;
@property (weak, nonatomic) IBOutlet UITextField *telefone;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *endereco;
@property (weak, nonatomic) IBOutlet UITextField *site;
@property (weak, nonatomic) IBOutlet UITextField *latitude;
@property (weak, nonatomic) IBOutlet UITextField *longitude;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property ContatoDao *dao;
@property (strong) Contato *contato;
@property id<FormularioContatoViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *botaoFoto;
- (IBAction)selecionaFoto:(id)sender;
- (IBAction)buscarCoordenadas:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *botaoMapa;

@end