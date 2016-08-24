//
//  ViewController.m
//  apps
//
//  Created by 王鹏 on 16/8/23.
//  Copyright © 2016年 王鹏. All rights reserved.
//

#import "ViewController.h"
#import "apps.h"
#import "TableViewCell.h"
#import "NSString+sandBoxPath.h"
@interface ViewController ()
@property (strong, nonatomic) NSArray *appsArr;

@property (strong, nonatomic) NSMutableDictionary *imageCache;

@property (strong, nonatomic) NSMutableDictionary *optionsCache;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - data
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.appsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"appCell"];
    apps *app = self.appsArr[indexPath.row];
    cell.nameLable.text = app.name;
    cell.loadLable.text = app.download;
    NSString *sandBox = [NSString catchSandBoxPath:app.icon];
    
    cell.iconImage.image = [UIImage imageNamed:@"user_default"];
    
    //判断内存缓存中有没有
    if (self.imageCache[app.icon] != nil) {
        cell.iconImage.image = self.imageCache[app.icon];
        NSLog(@"内存有数据");
        return cell;
    }
    
    //判断沙盒中有没有
    //取出沙盒中的数据
    UIImage *sandBoxImage = [UIImage imageWithContentsOfFile:sandBox];
    if (sandBoxImage) {
        NSLog(@"沙盒有数据");
        self.imageCache[app.icon] = sandBoxImage;
        //将image存到内存缓存
        [self.imageCache setObject:sandBoxImage forKey:app.icon];
        return cell;
    }
    
    
    if (self.optionsCache[app.icon] != nil) {
        NSLog(@"有任务");
        return cell;
    }
    //创建队列
    NSOperationQueue *concurrent = [[NSOperationQueue alloc] init];
    //创建任务
    NSBlockOperation *text = [NSBlockOperation blockOperationWithBlock:^{
        if (indexPath.row == 0) {
            [NSThread sleepForTimeInterval:5];
        }
        
        NSURL *imageurl = [NSURL URLWithString:app.icon];
        NSData *imageData = [NSData dataWithContentsOfURL:imageurl];
        UIImage *image = [UIImage imageWithData:imageData];
        [imageData writeToFile:sandBox atomically:YES];
        
        if (image != nil) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                NSLog(@"真在下载");
                [self.imageCache setObject:image forKey:app.icon];
                //[self.optionsCache setObject:text forKey:app.icon];
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
                [self.optionsCache removeObjectForKey:app.icon];
            }];
        }
    }];
    
    [concurrent addOperation:text];
    [self.optionsCache setObject:text forKey:app.icon];
    return cell;
}

#pragma mark - lazy
- (NSArray *)appsArr{
    if (_appsArr == nil) {
        _appsArr = [apps applist];
    }
    return _appsArr;
}

- (NSMutableDictionary *)imageCache{
    if (_imageCache == nil) {
        _imageCache = [NSMutableDictionary dictionary];
    }
    return _imageCache;
}

- (NSMutableDictionary *)optionsCache{
    if (_optionsCache == nil) {
        _optionsCache = [NSMutableDictionary dictionary];
    }
    return _optionsCache;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self.imageCache removeAllObjects];
}

@end
