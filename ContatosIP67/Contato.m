//
//  Contato.m
//  ContatosIP67
//
//  Created by Joviane Jardim on 14/01/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "Contato.h"

@implementation Contato

@dynamic nome, telefone, email, endereco, site, latitude, longitude, foto;

-(NSString *)description {
    return [NSString stringWithFormat:@"Nome: %@, Telefone: %@, Email: %@, Endereco: %@, Site: %@, Latitude: %@, Longitude: %@", self.nome, self.telefone, self.email, self.endereco, self.site, self.latitude, self.longitude];
}

- (CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

- (NSString *)title {
    return self.nome;
}

- (NSString *)subtitle {
    return self.email;
}
@end
