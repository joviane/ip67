//
//  ContatoDao.m
//  ContatosIP67
//
//  Created by Joviane Jardim on 14/01/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "ContatoDao.h"

@implementation ContatoDao

static ContatoDao *defaultDao = nil;

-(id) init {
    self = [super init];
    if (self) {
        //_contatos = [NSMutableArray new];
        [self inserirDadosIniciais];
        [self carregarContatos];
    }
    return self;
}

+(id) contatoDaoInstance{
    if (!defaultDao) {
        defaultDao = [ContatoDao new];
    }
    return defaultDao;
}

-(Contato *)novoContato {
    return [NSEntityDescription insertNewObjectForEntityForName:@"Contato" inManagedObjectContext:self.managedObjectContext];
}

-(void) adicionaContato:(Contato*) contato {
    [self.contatos addObject:contato];
    NSLog(@"Contatos: %@", self.contatos);
}

- (Contato *)buscaContatoDaPosicao:(NSInteger)posicao {
    return self.contatos[posicao];
}

- (void)removeContatoDaPosicao:(NSInteger)posicao {
    [self.contatos removeObjectAtIndex:posicao];
}

-(NSInteger) buscaPosicaoDoContato:(Contato *) contato {
    return [self.contatos indexOfObject:contato];
}

- (void) carregarContatos {
    NSFetchRequest *buscaContatos = [NSFetchRequest fetchRequestWithEntityName:@"Contato"];
    NSSortDescriptor *ordenarPorNome = [NSSortDescriptor sortDescriptorWithKey:@"nome" ascending:YES];
    
    buscaContatos.sortDescriptors = @[ordenarPorNome];
    NSArray *contatosImutaveis = [self.managedObjectContext executeFetchRequest:buscaContatos error:nil];
    _contatos = [contatosImutaveis mutableCopy];
}

- (void)inserirDadosIniciais {
    NSUserDefaults *configuracoes = [NSUserDefaults standardUserDefaults];
    BOOL dadosInseridos = [configuracoes boolForKey:@"dados_inseridos"];
    if (!dadosInseridos) {
        Contato *caelumSP = [NSEntityDescription insertNewObjectForEntityForName:@"Contato" inManagedObjectContext:self.managedObjectContext];
        caelumSP.nome = @"Caelum Unidade São Paulo";
        caelumSP.email = @"contato@caelum.com.br";
        caelumSP.endereco = @"São Paulo, SP, Rua Vergueiro, 3185";
        caelumSP.telefone = @"01155712751";
        caelumSP.site = @"http://www.caelum.com.br";
        caelumSP.latitude = [NSNumber numberWithDouble:-23.5883034];
        caelumSP.longitude = [NSNumber numberWithDouble:-46.632369];
        
        [self saveContext];
        [configuracoes setBool:YES forKey:@"dados_inseridos"];
        [configuracoes synchronize];
    }
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "br.com.caelum.ContatosIP67" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ContatosIP67" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ContatosIP67.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
