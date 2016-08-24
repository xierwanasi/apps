//
//  apps.m
//  apps
//
//  Created by 王鹏 on 16/8/24.
//  Copyright © 2016年 王鹏. All rights reserved.
//

#import "apps.h"

@implementation apps

+ (instancetype)appsWithDict:(NSDictionary *)dict{
    
    id obj = [[apps alloc] init];
    [obj setValuesForKeysWithDictionary:dict];
    return obj;
    
}

+ (NSArray *)applist{
    NSArray *arr = [NSArray arrayWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"apps.plist" withExtension:nil]];
    
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        apps *app = [apps appsWithDict:obj];
        [arrM addObject:app];
    }];
    return arrM.copy;
}
@end
