//
//  NSString+sandBoxPath.m
//  apps
//
//  Created by 王鹏 on 16/8/24.
//  Copyright © 2016年 王鹏. All rights reserved.
//

#import "NSString+sandBoxPath.h"

@implementation NSString (sandBoxPath)

+ (NSString *)catchSandBoxPath:(NSString *)URLStr{
    NSString *sandBox = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    NSString *sandBoxPath = [sandBox stringByAppendingPathComponent:URLStr.lastPathComponent];
    
    return sandBoxPath;
}

@end
