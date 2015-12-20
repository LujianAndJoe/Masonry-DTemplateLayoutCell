//
//  ViewController.m
//  MansoryLayout
//
//  Created by Joe on 15/12/14.
//  Copyright © 2015年 Joe. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "FeedModel.h"
#import "FeedCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray *feedsDataFormJSON;
@property (strong, nonatomic) NSMutableArray *feeds;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self loadJSONData:^{
        
        self.feeds = @[].mutableCopy;
        [self.feeds addObject:self.feedsDataFormJSON.mutableCopy];
        [self.tableView registerClass:[FeedCell class] forCellReuseIdentifier:@"feedCell"];
        [self.tableView reloadData];
    }];
}

- (void)loadJSONData:(void(^)())then {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *dataPath =[[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
        NSData *datas = [NSData dataWithContentsOfFile:dataPath];
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:datas
                                                                       options:NSJSONReadingAllowFragments
                                                                         error:nil];
        
        NSArray *feedDatas = dataDictionary[@"feed"];
        NSMutableArray *mFeedDatas = @[].mutableCopy;
        [feedDatas enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [mFeedDatas addObject:[FeedModel feedWithDictionary:obj]];
        }];
        
        self.feedsDataFormJSON = mFeedDatas;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            !then ? : then();
        });
        
    });
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.feeds count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.feeds[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feedCell"];
    [self setupModelOfCell:cell atIndexPath:indexPath];
    return cell;
}

- (void) setupModelOfCell:(FeedCell *) cell atIndexPath:(NSIndexPath *) indexPath {
    
    cell.fd_enforceFrameLayout = YES;
    cell.feed = self.feeds[indexPath.section][indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.tableView fd_heightForCellWithIdentifier:@"feedCell" cacheByIndexPath:indexPath configuration:^(FeedCell *cell) {
        [self setupModelOfCell:cell atIndexPath:indexPath];
    }];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableArray *mutableEntities = self.feeds[indexPath.section];
        [mutableEntities removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

@end
