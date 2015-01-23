//
//  ViewController.m
//  ContatosIP67
//
//  Created by Joviane Jardim on 22/12/14.
//  Copyright (c) 2014 Caelum. All rights reserved.
//

#import "FormularioContatoViewController.h"

@implementation FormularioContatoViewController

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.dao = [ContatoDao contatoDaoInstance];
        self.navigationItem.title = @"Cadastro";
        UIBarButtonItem *adiciona = [[UIBarButtonItem alloc] initWithTitle:@"Adiciona" style:UIBarButtonItemStylePlain target:self action:@selector(criaContato)];
        self.navigationItem.rightBarButtonItem = adiciona;
    }
    return self;
}

- (void)pegaDadosDoFormulario {
    if (!self.contato) {
        self.contato = [self.dao novoContato];
    }
    if ([self.botaoFoto backgroundImageForState: UIControlStateNormal]) {
        self.contato.foto = [self.botaoFoto backgroundImageForState: UIControlStateNormal];
    }
    self.contato.nome = self.nome.text;
    self.contato.telefone = self.telefone.text;
    self.contato.email = self.email.text;
    self.contato.endereco = self.endereco.text;
    self.contato.site = self.site.text;
    self.contato.latitude = [NSNumber numberWithDouble: [self.latitude.text doubleValue]];
    self.contato.longitude = [NSNumber numberWithDouble: [self.longitude.text doubleValue]];
}

- (void)viewDidLoad {
    if (self.contato) {
        self.navigationItem.title = @"Alterar";
        UIBarButtonItem *altera = [[UIBarButtonItem alloc] initWithTitle:@"Confirmar" style:UIBarButtonItemStylePlain target:self action:@selector(atualizaContato)];
        self.navigationItem.rightBarButtonItem = altera;
        
        self.nome.text = self.contato.nome;
        self.telefone.text = self.contato.telefone;
        self.email.text = self.contato.email;
        self.endereco.text = self.contato.endereco;
        self.site.text = self.contato.site;
        self.latitude.text = [self.contato.latitude stringValue];
        self.longitude.text = [self.contato.longitude stringValue];
        
        if (self.contato.foto) {
            [self.botaoFoto setTitle:nil forState:UIControlStateNormal];
            [self.botaoFoto setBackgroundImage:self.contato.foto forState:UIControlStateNormal];
        }
    }
}

- (void)criaContato {
    [self pegaDadosDoFormulario];
    [self.dao adicionaContato:self.contato];
    
    if (self.delegate) {
        [self.delegate contatoAdicionado:self.contato];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)atualizaContato {
    [self pegaDadosDoFormulario];
    
    if (self.delegate) {
        [self.delegate contatoAtualizado:self.contato];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)buscarCoordenadas:(id)sender {
    [self.loading startAnimating];
    self.botaoMapa.hidden = YES;
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder geocodeAddressString: self.endereco.text completionHandler: ^(NSArray *resultados, NSError *error) {
        [self coordenadaDosResultados: resultados error: error];
    }];
}

-(void)coordenadaDosResultados:(NSArray *)resultados error:(NSError *) error{
    NSLog(@"Geocoder");
    if (error == nil && [resultados count] > 0) {
        CLPlacemark *resultado = resultados[0];
        CLLocationCoordinate2D coordenada = resultado.location.coordinate;
        self.latitude.text = [NSString stringWithFormat:@"%f", coordenada.latitude];
        self.longitude.text = [NSString stringWithFormat:@"%f", coordenada.longitude];
    } else {
        NSLog(@"Erro: %@ Resultados: %@", error, resultados);
    }
    [self.loading stopAnimating];
    self.botaoMapa.hidden = NO;
}

- (IBAction)selecionaFoto:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        //câmera disponível
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Escolha a foto do contato" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Tirar foto", @"Escolher da biblioteca", nil];
        [sheet showInView:self.view];
    } else {
        UIImagePickerController *picker = [UIImagePickerController new];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *imagemSelecionada = [info valueForKey:UIImagePickerControllerEditedImage];
    [self.botaoFoto setBackgroundImage:imagemSelecionada forState:UIControlStateNormal];
    [self.botaoFoto setTitle: nil forState: UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    switch (buttonIndex) {
        case 0:
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 1:
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        default:
            return;
    }
    [self presentViewController:picker animated:YES completion:nil];
}

@end
