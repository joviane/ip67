//
//  ListaContatosViewController.h
//  ContatosIP67
//
//  Created by Joviane Jardim on 15/01/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContatoDao.h"
#import "FormularioContatoViewController.h"
#import "GerenciadorDeAcoes.h"

@interface ListaContatosViewController : UITableViewController<FormularioContatoViewControllerDelegate>

@property ContatoDao *dao;
@property Contato *contatoSelecionado;
@property NSInteger linhaDestaque;
@property (readonly) GerenciadorDeAcoes *gerenciador;

@end
