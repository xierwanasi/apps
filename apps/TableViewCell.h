//
//  TableViewCell.h
//  apps
//
//  Created by 王鹏 on 16/8/24.
//  Copyright © 2016年 王鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UILabel *nameLable;

@property (weak, nonatomic) IBOutlet UILabel *loadLable;
@end
