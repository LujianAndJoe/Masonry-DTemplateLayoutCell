//
//  FeedModel.h
//  MansoryLayout
//
//  Created by Joe on 15/12/20.
//  Copyright © 2015年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedModel : NSObject

@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *imageName;
@property (copy, nonatomic) NSString *time;

+ (instancetype) feedWithDictionary:(NSDictionary *) dictionary;

- (instancetype) initWithDictionary:(NSDictionary *) dictionary;

@end
