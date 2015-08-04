//
//  RawMatarialCell.m
//  Catalouge
//
//  Created by Shameem Ahamad on 7/31/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "RawMatarialCell.h"

@implementation RawMatarialCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addLeather:(AddLeather)addLeather{

    _addLeather = addLeather;
}

- (void)addLining:(AddLining)addLining{
    
    _addLining = addLining;
}

- (IBAction)leatherBtn:(id)sender{

    _addLeather ? _addLeather(self.indeX) : @"";

}
- (IBAction)liningBtn:(id)sender{

    _addLining ? _addLining(self.indeX) : @"";

}



#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
//    if (tableView == [self tbl_RawMatarial]) {
//        
//        return rowForRawMatarial;
//    }
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *FirstCell = @"FirstCell1";
    static NSString *AddCell = @"AddCell";
    static NSString *LastCell = @"LastCell";
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:FirstCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:FirstCell];
        
    }
    cell.textLabel.text = @"Shameem";
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    Articles *article = [[self arrArticles] objectAtIndex:indexPath.row];
//    [[AppDataManager sharedAppDatamanager] newTransactionWithArticleId:article.articleid];
//    [[AppDataManager sharedAppDatamanager] newTransactionWithArticleId:article.articleid];
//    [self tapOnRelatedBtn:self.dargButton];
//    [self refreshUI];
    
}


@end
