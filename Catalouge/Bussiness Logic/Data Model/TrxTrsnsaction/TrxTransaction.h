//
//  TrxTransaction.h
//  Catalouge
//
//  Created by Shameem Ahamad on 6/1/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface TrxTransaction : NSObject

@property(nonatomic,strong) NSString *TransactionId;
@property(nonatomic,strong) NSString *articleid;
@property(nonatomic,strong) Articles *article;
@property(nonatomic,strong) NSString *articlename;
@property(nonatomic,strong) NSString *ischange;
@property(nonatomic,strong) NSString *isnew;
@property(nonatomic,strong) NSString *lastid;
@property(nonatomic,strong) NSString *soleid;
@property(nonatomic,assign) TransactionType transactionType;





//Header
@property(nonatomic,strong) Lasts *last;
@property(nonatomic,strong) Rawmaterials *Sole;
@property(nonatomic,strong) Rawmaterials *SoleMaterial;
//TODO:: Change ArticlesRawmaterials--> Rawmaterials
@property(nonatomic,strong) ArticlesRawmaterials *socksMaterial;
@property(nonatomic,strong) Rawmaterials *socksMaterialNew;
//Footer
@property(nonatomic,strong) NSString *qty;
@property(nonatomic,strong) NSString *qty_unit;
@property(nonatomic,strong) NSString *size;
@property(nonatomic,strong) NSString *remark;


//Lining and Leather
@property(nonatomic,strong) NSMutableArray *rawmaterialsForLeathers;
@property(nonatomic,strong) NSMutableArray *rawmaterialsForLinings;




@property(nonatomic,strong) NSArray *trx_Rawmaterials;


@end
