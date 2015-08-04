//
//  RawMatarialCell.h
//  Catalouge
//
//  Created by Shameem Ahamad on 7/31/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^AddLeather)(int rowIndex);
typedef void(^AddLining)(int rowIndex);

@interface RawMatarialCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,assign) NSInteger indeX;
@property(nonatomic,strong) AddLining addLining;
@property(nonatomic,strong) AddLeather addLeather;
@property(nonatomic,strong) IBOutlet UITableView *tbl_AddLeather;
@property(nonatomic,strong) IBOutlet UITableView *tbl_AddLining;

- (void)addLeather:(AddLeather)addLeather;
- (void)addLining:(AddLining)addLining;

- (IBAction)leatherBtn:(id)sender;
- (IBAction)liningBtn:(id)sender;
@end
