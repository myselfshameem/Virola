//
//  CXTableView.h
//  CitiXsys
//
//  Created by Rishu Kumar on 16/11/12.
//  Copyright (c) 2012 CitiXSys Technologies India Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXTableView : UITableView {
    UIEdgeInsets    _priorInset;
    BOOL            _priorInsetSaved;
    BOOL            _keyboardVisible;
    CGRect          _keyboardRect;
}

- (void)adjustOffsetToIdealIfNeeded;

@end
