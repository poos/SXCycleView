//
//  CycleCollectionCell.m
//  test
//
//  Created by n369 on 16/8/15.
//  Copyright © 2016年 n369. All rights reserved.
//

#import "SXCycleCollectionCell.h"
#import "UIImageView+WebCache.h"

static NSString *const image = @"imageKey";
static NSString *const title = @"titleKey";

@implementation SXCycleCollectionCell

#pragma mark-------------set-----------------
- (void)setCellImageIsUrlData:(NSDictionary *)dicData {
    [self setImage:dicData[image] andIsImage:NO];
    [self setTitle:dicData[title]];
}

- (void)setCellData:(NSDictionary *)dicData {
    [self setImage:dicData[image] andIsImage:YES];
    [self setTitle:dicData[title]];
}

- (void)setImage:(id)data andIsImage:(BOOL)isImage {
    if (isImage) {
        [_imageView setImage:(UIImage *)data];
    } else {
        [_imageView sd_setImageWithURL:[NSURL URLWithString:(NSString *)data]];
    }
}

- (void)setTitle:(NSString *)titleStr {
    [_titleLabel setText:titleStr];
    if ([titleStr isEqualToString:@""]) {
        [[self.contentView viewWithTag:123] setHidden:YES];
    } else {
        [[self.contentView viewWithTag:123] setHidden:NO];
    }
}

#pragma mark-------------init-----------------
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
        [self setupTitleLabel];
    }
    return self;
}

- (void)setupImageView {
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self.contentView addSubview:_imageView];
}

- (void)setupTitleLabel {
    UIView *titleBackView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 40, self.bounds.size.width, 40)];
    titleBackView.tag = 123;
    titleBackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
    [self.contentView addSubview:titleBackView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.bounds.size.height - 30, self.bounds.size.width - 80, 20)];
    _titleLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_titleLabel];
}

@end
