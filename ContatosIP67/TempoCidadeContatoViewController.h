
#import <UIKit/UIKit.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <AFNetworking/AFNetworking.h>
#import "Contato.h"

@interface TempoCidadeContatoViewController : UIViewController

@property (weak, nonatomic) Contato *contato;
@property (weak, nonatomic) IBOutlet UIImageView *iconeTempo;
@property (weak, nonatomic) IBOutlet UILabel *tempMax;
@property (weak, nonatomic) IBOutlet UILabel *tempMin;
@property (weak, nonatomic) IBOutlet UILabel *condicao;

@end
