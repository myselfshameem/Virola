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
@property(nonatomic,strong) NSString *qty;
@property(nonatomic,strong) NSString *qty_unit;
@property(nonatomic,strong) NSString *size;
@property(nonatomic,strong) NSString *remark;


@property(nonatomic,strong) Articles *article;
@property(nonatomic,strong) Rawmaterials *Leather1;
@property(nonatomic,strong) Rawmaterials *Leather2;
@property(nonatomic,strong) Rawmaterials *Leather3;
@property(nonatomic,strong) Rawmaterials *Leather4;
@property(nonatomic,strong) Rawmaterials *Leather5;


@property(nonatomic,strong) Rawmaterials *Lining1;
@property(nonatomic,strong) Rawmaterials *Lining2;
@property(nonatomic,strong) Rawmaterials *Lining3;
@property(nonatomic,strong) Rawmaterials *Lining4;
@property(nonatomic,strong) Rawmaterials *Lining5;



@property(nonatomic,strong) Rawmaterials *Sole;
@property(nonatomic,strong) Rawmaterials *SoleMaterial;

@property(nonatomic,strong) NSArray *rawmaterials;


@end
