//
//  QuickLookViewController.h
//  Catalouge
//
//  Created by Shameem Ahamad on 5/25/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import <QuickLook/QuickLook.h>

@interface QuickLookViewController : QLPreviewController
@property(nonatomic,strong) NSMutableArray *arrayOfDocuments;
@end
