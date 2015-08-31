//
//  MainTabbarController.m
//  Catalouge
//
//  Created by Shameem Ahamad on 5/10/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "MainTabbarController.h"
#import "HomeViewController.h"
@interface MainTabbarController ()<UITabBarControllerDelegate>

@end

@implementation MainTabbarController
- (BOOL)shouldAutorotate{
    
    UIViewController *ctrl = [[(UINavigationController*)[self selectedViewController] viewControllers] firstObject];
    if ([ctrl isKindOfClass:[HomeViewController class]] && !isIPad()) {
        
//        if(!([self interfaceOrientation] == UIInterfaceOrientationPortrait) || ([self interfaceOrientation] == UIInterfaceOrientationPortraitUpsideDown)){
//        
//            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];
//        }
        return NO;
    }
    return YES;
}
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation NS_AVAILABLE_IOS(6_0){
//    
//    
//    return UIInterfaceOrientationPortrait;
//    
//}
//- (NSUInteger)supportedInterfaceOrientations NS_AVAILABLE_IOS(6_0){
//    
//    
//    return UIInterfaceOrientationMaskPortrait;
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureTabbar];
    self.delegate = self;
    
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
            if (isIPad()) {
                item.selectedImage = [[UIImage imageNamed:@"Tabbar_Account_Selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                item.image = [[UIImage imageNamed:@"Tabbar_Account"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

            }
        }

        else if(i==5){
            
            item.title= @"Sync";
            if (isIPad()) {
                item.selectedImage = [[UIImage imageNamed:@"Tabbar_Sync_Selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                item.image = [[UIImage imageNamed:@"Tabbar_Sync"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            }
            
        }

    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{

    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

    if ([tabBarController selectedIndex] == 0) {
        
        [[(UINavigationController*)viewController viewControllers] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            //[self ];
        }];
        
    }

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
