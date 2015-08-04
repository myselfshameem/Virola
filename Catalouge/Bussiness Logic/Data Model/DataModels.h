//
//  DataModels.h
//
//  Created by iVend  on 5/21/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//
#import "UIDevice+IdentifierAddition.h"
#import "User.h"
#import "Account.h"

#import "RawmaterialApiResponse.h"
#import "Rawmaterials.h"
#import "Lasts.h"
#import "Rawmaterials.h"
#import "RawmaterialApiResponse.h"

#import "ArticlesApiResponse.h"
#import "Articles.h"
#import "ArticlesRawmaterials.h"
#import "Article_Image.h"



#import "ArticleColor.h"
#import "Colors.h"


#import "Agents.h"
#import "Clients.h"
#import "ClientsApiResponse.h"

#import "CXSSqliteHelper.h"
#import "NSString+MyString.h"
#import "TrxTransaction.h"
#import "AddClientViewController.h"
#import "NSString+MyString.h"
#import "CustomeAlert.h"
#import "Trx_Rawmaterials.h"
#import "NSString+MyString.h"
#import "NSUserDefaults+UserDetail.h"



#define ROOT_API_PATH           @"http://demo.dselva.info/virolainternational/api/mobile/v1"

//#define ROOT_API_PATH           @"http://103.237.173.71/virolainternational/api/mobile/v1"
#define GET_LOG_IN_API          @"login.php"
#define GET_LOG_OUT_API         @"logout.php"
#define GET_RAW_MATERIAL_API    @"getrawmaterials.php"
#define GET_COLOR_API           @"getcolors.php"
#define GET_ARTICLE_API         @"getarticles.php"
#define GET_CLIENTS_API         @"getclients.php"
#define UPDATE_CLIENTS_API      @"updateclient.php"
#define ADD_CLIENTS_API         @"addclient.php"
#define ADD_ORDER_API           @"addorder.php"


#define isIPad()                ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)



#define PROGRESS_COUNT @"PROGRESS_COUNT"
static NSString *kDetailedViewControllerID = @"DetailView";    // view controller storyboard id
static NSString *kCellID = @"NewCell";                          // UICollectionViewCell storyboard id

