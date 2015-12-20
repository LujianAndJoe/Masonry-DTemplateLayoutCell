//
//  FeedCell.m
//  MansoryLayout
//
//  Created by Joe on 15/12/20.
//  Copyright © 2015年 Joe. All rights reserved.
//

#import "FeedCell.h"

@interface FeedCell ()

@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UILabel *contentLabel;
@property (weak, nonatomic) UIImageView *contentImageView;
@property (weak, nonatomic) UILabel *userLabel;
@property (weak, nonatomic) UILabel *timeLabel;

@end

@implementation FeedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.bounds = [UIScreen mainScreen].bounds;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
        [self setttingViewAtuoLayout];
    }
    return self;
}

- (void) createView {
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    UIImageView *contentImageView = [[UIImageView alloc] init];
    contentImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:contentImageView];
    self.contentImageView = contentImageView;
    
    UILabel *userLabel = [[UILabel alloc] init];
    [self.contentView addSubview:userLabel];
    self.userLabel = userLabel;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:timeLabel];
    self.timeLabel = timeLabel;
}

#pragma mark - 在此方法内使用 Masonry 设置控件的约束,设置约束不需要在layoutSubviews中设置，只需要在初始化的时候设置

- (void) setttingViewAtuoLayout {
    
    int magin = 4;
    int padding = 10;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(padding);
        make.right.mas_equalTo(-padding);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(magin);
    }];
    
    [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(magin);
    }];
    
    [self.userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.mas_equalTo(self.contentImageView.mas_bottom).offset(magin);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-magin); 
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userLabel);
        make.right.equalTo(self.titleLabel);
    }];
}

- (void)setFeed:(FeedModel *)feed {
    _feed = feed;
    self.titleLabel.text = feed.title;
    self.contentLabel.text = feed.content;
    self.contentImageView.image = feed.imageName.length > 0 ? [UIImage imageNamed:feed.imageName] : nil;
    self.userLabel.text = feed.username;
    self.timeLabel.text = feed.time;
}

// If you are not using auto layout, override this method, enable it by setting
// "fd_enforceFrameLayout" to YES.
- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat totalHeight = 0;
    totalHeight += [self.titleLabel sizeThatFits:size].height;
    totalHeight += [self.contentLabel sizeThatFits:size].height;
    totalHeight += [self.contentImageView sizeThatFits:size].height;
    totalHeight += [self.userLabel sizeThatFits:size].height;
    totalHeight += 40; // margins
    return CGSizeMake(size.width, totalHeight);
}

@end
