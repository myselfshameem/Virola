//
//  DataModels.h
//
//  Created by iVend  on 5/21/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//


typedef enum : NSUInteger {
    TransactionTypeNotAvailable = -1,
    TransactionTypeNewDevelopment = 0,
    TransactionTypeArticle = 1,
} TransactionType;

typedef enum : NSUInteger {
    QR_CODE = 0,
    _2DBAR_CODE = 1,
} BAR_CODE_TYPE;


#import "ShippingTerms.h"
#import "PaymentTermRemarks.h"
#import "Modeofshipping.h"
#import "PaymentTerms.h"
#import "GetOtherDetailsApiResponse.h"
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
#import "Orders.h"
#import "GetOrdersApiResponse.h"

//#define ROOT_API_PATH                           @"http://demo.dselva.info/virolainternational/api/mobile/v2"

#define ROOT_API_PATH                           @"http://103.237.173.71/virolainternational/api/mobile/v2"
#define GET_LOG_IN_API                          @"login.php"
#define GET_LOG_OUT_API                         @"logout.php"
#define GET_RAW_MATERIAL_API                    @"getrawmaterials.php"
#define GET_COLOR_API                           @"getcolors.php"
#define GET_ARTICLE_API                         @"getarticles.php"
#define GET_CLIENTS_API                         @"getclients.php"
#define UPDATE_CLIENTS_API                      @"updateclient.php"
#define ADD_CLIENTS_API                         @"addclient.php"
#define ADD_ORDER_API                           @"addorder.php"
#define GET_PAYMENT_SHIPPING_TERMS              @"getotherdetails.php"
#define GET_Orders                              @"getOrder.php"
#define UPLOAD_Image_API                        @"uploadPhoto.php"
#define RE_RESEND_ORFDER_API                    @"sendemail.php"
#define CHNAGE_PASSWORD                         @"changepassword.php"


#define isIPad()                ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)



#define PROGRESS_COUNT @"PROGRESS_COUNT"
static NSString *kDetailedViewControllerID = @"DetailView";    // view controller storyboard id
static NSString *kCellID = @"NewCell";                          // UICollectionViewCell storyboard id






///
// HTTP ERROR CODE
//

#define INVALID_USER 801
#define LAST_SELECTION 1999
#define SOLE_SELECTION 1998
#define SOLE_COLOR_SELECTION 1997
#define SOLE_MATERIAL_SELECTION 1996
#define LEATHER_SELECTION 1995
#define LEATHER_COLOR_SELECTION 1994
#define LINING_SELECTION 1993
#define LINING_COLOR_SELECTION 1992
#define QTY_SELECTION 1991
#define PAIR_SELECTION 1990
#define SIZE_SELECTION 1989

#define PAYMENT_TERMS_SELECTION 1988
#define PAYMENT_TERMS_REMARKS_SELECTION 1987
#define SHIPPING_TERMS_SELECTION 1986
#define MODE_OF_SHIPPING_SELECTION 1985
#define SOCK_SELECTION 1984
#define SOCK_COLOR_SELECTION 1983
#define AGENT_SELECTION 1982





