//
//  SocksCell.h
//  
//
//  Created by Shameem Ahamad on 10/13/15.
//
//

#import <UIKit/UIKit.h>

@interface SocksCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_Title1;
@property (weak, nonatomic) IBOutlet UIView *vw_1;
@property (weak, nonatomic) IBOutlet UITextField *txt_1;

@property (weak, nonatomic) IBOutlet UILabel *lbl_Title2;
@property (weak, nonatomic) IBOutlet UIView *vw_2;
@property (weak, nonatomic) IBOutlet UITextField *txt_2;
@property (assign, nonatomic) NSInteger cellType;
@property (assign, nonatomic) NSInteger indexOfCell;


- (void)initilizeCell;
- (IBAction)dropDwonSelectedSocks:(id)sender;
- (IBAction)dropDwonSelectedSocksColor:(id)sender;
typedef void(^CallbackForSocks)(__weak SocksCell *cell, NSInteger tag,NSInteger indexOfCell);

@property (strong, nonatomic) CallbackForSocks callback;

- (void)callbackForSelectedSocksAndColors:(CallbackForSocks)callback;

@end
