//
//  FeedModel.m
//  MansoryLayout
//
//  Created by Joe on 15/12/20.
//  Copyright © 2015年 Joe. All rights reserved.
//

#import "FeedModel.h"

@implementation FeedModel

+ (instancetype)feedWithDictionary:(NSDictionary *)dictionary {
    return [[self alloc] initWithDictionary:dictionary];
}

- (instancetype) initWithDictionary:(NSDictionary *) dictionary {
    
    if (self = [super init]) {
        self.title = dictionary[@"title"];
        self.content = dictionary[@"content"];
        self.username = dictionary[@"username"];
        self.time = dictionary[@"time"];
        self.imageName = dictionary[@"imageName"];
    }
    return self;
}

@end
