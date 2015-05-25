//
//  ContatoDao.h
//  ContatosIP67
//
//  Created by Joviane Jardim on 14/01/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contato.h"

@interface ContatoDao : NSObject

@property (strong, readonly) NSMutableArray *contatos;

-(void) adicionaContato:(Contato*) contato;
-(Contato *) buscaContatoDaPosicao:(NSInteger) posicao;
-(void) removeContatoDaPosicao:(NSInteger) posicao;
-(NSInteger) buscaPosicaoDoContato:(Contato *) contato;
-(Contato *)novoContato;

+(id) contatoDaoInstance;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property NSDate *data;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
