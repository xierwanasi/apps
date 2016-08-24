//
//  apps.h
//  apps
//
//  Created by 王鹏 on 16/8/24.
//  Copyright © 2016年 王鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface apps : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *download;


+ (instancetype)appsWithDict :(NSDictionary *)dict;

+ (NSArray *)applist;
@end
