//
//  QuickLookViewController.m
//  Catalouge
//
//  Created by Shameem Ahamad on 5/25/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "QuickLookViewController.h"

@interface QuickLookViewController ()<QLPreviewControllerDataSource,QLPreviewControllerDelegate>

@end

@implementation QuickLookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.dataSource = self;
    
}
- (void)viewWillAppear:(BOOL)animated{

    //[self reloadData];

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
/*!
 * @abstract Returns the number of items that the preview controller should preview.
 * @param controller The Preview Controller.
 * @result The number of items.
 */
- (NSInteger) numberOfPreviewItemsInPreviewController: (QLPreviewController *) controller
{
    return [self.arrayOfDocuments count];
}

- (id <QLPreviewItem>)previewController: (QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    Article_Image *article = [[self arrayOfDocuments] objectAtIndex:index];
    NSString *fileName = [article.imagePath lastPathComponent];
    NSString *filePath = [[[AppDataManager sharedAppDatamanager] imageDirPath] stringByAppendingPathComponent:fileName];
    
    return [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"Clinet_QRCode" ofType:@"png"]];
}

@end
