//
//  MainTabbarController.m
//  Catalouge
//
//  Created by Shameem Ahamad on 5/10/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "MainTabbarController.h"
@interface MainTabbarController ()

@end

@implementation MainTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureTabbar];
    
}
- (void)configureTabbar {
    
    //[self.tabBar setBackgroundImage:[[UIImage imageNamed:@"tab_bar"] resizableImageWithCapInsets:UIEdgeInsetsMake(50, 10, 50, 10)]];
    [self.tabBar setAlpha:1.0];
    
    for (int i = 0; i < [self.tabBar.items count]; i++) {
        
        UITabBarItem *item = [self.tabBar.items objectAtIndex:i];
        
        if(i==0){
            
            item.title= @"Home";
            item.selectedImage = [[UIImage imageNamed:@"Tabbar_Home_Selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            item.image = [[UIImage imageNamed:@"Tabbar_Home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
        }
        else if (i==1){
            
            
            item.title= @"Article";
            item.selectedImage = [[UIImage imageNamed:@"Tabbar_Article_Selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            item.image = [[UIImage imageNamed:@"Tabbar_Article"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
        }
        
        else if(i==2){
            item.title= @"Clients";
            item.selectedImage = [[UIImage imageNamed:@"Tabbar_Clients_Selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            item.image = [[UIImage imageNamed:@"Tabbar_Clients"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        
        else if(i==3){
            
            item.title= @"Cart";
            item.selectedImage = [[UIImage imageNamed:@"Tabbar_Cart_Selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            item.image = [[UIImage imageNamed:@"Tabbar_Cart"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

            
        }
        
        else if(i==4){
            
            item.title= @"Account";
            item.selectedImage = [[UIImage imageNamed:@"Tabbar_Account_Selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            item.image = [[UIImage imageNamed:@"Tabbar_Account"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }


    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
