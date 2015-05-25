#import "TempoCidadeContatoViewController.h"
@interface TempoCidadeContatoViewController (){
    NSDictionary *main;
    NSDictionary *weather;
}
@end

@implementation TempoCidadeContatoViewController

static NSString const *BASE_URL = @"http://api.openweathermap.org/data/2.5/weather?";
static NSString const *BASE_URL_IMAGEM = @"http://openweathermap.org/img/w/";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *url = [NSString stringWithFormat:@"%@lat=%@&lon=%@&units=metric", BASE_URL, self.contato.latitude, self.contato.longitude];
    NSMutableURLRequest *requisicao = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:url parameters:nil error:nil];
    
    // Pra fazer um post é só gerar o JSON passando nos parameters um NSDictionary ou NSMutableDictionary
    
    [requisicao setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    AFHTTPRequestOperation *operacao = [[AFHTTPRequestOperation alloc] initWithRequest:requisicao];
    operacao.responseSerializer = [AFJSONResponseSerializer serializer];
    [operacao.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"application/json"]];
    
    [operacao setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *resposta = (NSDictionary *) responseObject;
        NSLog(@"%@", resposta);
        main = resposta[@"main"];
        NSArray *weather_temp = resposta[@"weather"];
        weather = weather_temp[0];
        NSNumber *max = main[@"temp_max"];
        NSNumber *min = main[@"temp_min"];
        
        self.tempMax.text = [max stringValue];
        self.tempMin.text = [min stringValue];
        self.condicao.text = weather[@"main"];
        
        [self recuperaImagem];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Erro ao recuperar o tempo" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    }];
    
    [operacao start];
}

- (void)recuperaImagem {
    NSString *iconURL = [NSString stringWithFormat: @"%@%@.png", BASE_URL_IMAGEM, weather[@"icon"]];
    NSURL *url = [NSURL URLWithString:iconURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.iconeTempo setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        self.iconeTempo.image = image;
    } failure:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
