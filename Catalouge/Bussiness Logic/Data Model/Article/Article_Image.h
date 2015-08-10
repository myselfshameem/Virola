//
//  Images.h
//
//  Created by iVend  on 8/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Article_Image : NSObject <NSCoding>

@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) NSString *articleid;

+ (Article_Image *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
