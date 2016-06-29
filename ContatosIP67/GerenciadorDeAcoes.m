//
//  GerenciadorDeAcoes.m
//  ContatosIP67
//
//  Created by Joviane Jardim on 15/01/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "GerenciadorDeAcoes.h"
#import "TempoCidadeContatoViewController.h"

@implementation GerenciadorDeAcoes

-(id)initWithContato:(Contato *)contato {
    self = [super init];
    if (self) {
        self.contato = contato;
    }
    return self;
}

- (void)acoesDoController:(UIViewController *) controller{
    self.controller = controller;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:self.contato.nome message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *ligar = [UIAlertAction actionWithTitle:@"Ligar" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self ligar];
    }];
    UIAlertAction *enviarEmail = [UIAlertAction actionWithTitle:@"Enviar Email" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self enviarEmail];
    }];
    UIAlertAction *visualizarSite = [UIAlertAction actionWithTitle:@"Visualizar site" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self abrirSite];
    }];
    UIAlertAction *abrirMapa = [UIAlertAction actionWithTitle:@"Abrir Mapa" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self mostrarMapa];
    }];
    UIAlertAction *tempoLocal = [UIAlertAction actionWithTitle:@"Tempo local" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self tempoLocal];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancelar" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:ligar];
    [alert addAction:enviarEmail];
    [alert addAction:visualizarSite];
    [alert addAction:abrirMapa];
    [alert addAction:tempoLocal];
    [alert addAction:cancel];
    
    [controller presentViewController:alert animated:YES completion:nil];
    
    //UIActionSheet *opcoes = [[UIActionSheet alloc] initWithTitle: self.contato.nome delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Ligar", @"Enviar Email", @"Visualizar site", @"Abrir Mapa", @"Tempo local", nil];
    //[opcoes showInView:controller.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"Clicou em algum botão");
    switch (buttonIndex) {
        case 0:
            [self ligar];
            break;
        case 1:
            [self enviarEmail];
            break;
        case 2:
            [self abrirSite];
            break;
        case 3:
            [self mostrarMapa];
            break;
        case 4:
            [self tempoLocal];
            break;
        default:
            break;
    }
}

- (void)abrirAplicativoComURL:(NSString *)url {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

-(void)ligar {
    NSLog(@"Ligar");
    UIDevice *device = [UIDevice currentDevice];
    NSLog(@"%@, %@", device.model, device.name);
    if ([device.model isEqualToString:@"iPhone"]) {
        // se for iPhone, podemos pedir para fazer um telefonema
        NSString *numero = [NSString stringWithFormat:@"tel:%@", self.contato.telefone];
        [self abrirAplicativoComURL:numero];

    } else {
        [[[UIAlertView alloc] initWithTitle:@"Impossivel fazer ligacao" message:@"Seu dispositivo nao e um iPhone" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
}

-(void)enviarEmail {
    NSLog(@"E-mail");
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *enviadorEmail = [MFMailComposeViewController new];
        
        // configuração do controller de e-mail
        enviadorEmail.mailComposeDelegate = self;

        [enviadorEmail setToRecipients:@[self.contato.email]];
        [enviadorEmail setSubject:@"Caelum"];
        [enviadorEmail setTitle:@"Batman"];

        [self.controller presentViewController:enviadorEmail animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ops" message:@"Não é possível enviar e-mails!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }

}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self.controller dismissViewControllerAnimated:YES completion:nil];
}

-(void)abrirSite {
    NSLog(@"Site");
    NSString *url = self.contato.site;
    [self abrirAplicativoComURL:url];
}

-(void)mostrarMapa {
    NSLog(@"Mapa");
    NSString *url = [[NSString stringWithFormat: @"http://maps.google.com/maps?q=%@", self.contato.endereco] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
    [self abrirAplicativoComURL:url];
}

- (void) tempoLocal {
    TempoCidadeContatoViewController *tempo = [TempoCidadeContatoViewController new];
    tempo.contato = self.contato;
    
    [self.controller.navigationController pushViewController:tempo animated:YES];
}
@end
