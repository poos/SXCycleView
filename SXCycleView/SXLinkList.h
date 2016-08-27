//
//  SXLinkList.h
//  test
//
//  Created by xiaoR
//  github地址:https://github.com/poos/SXCycleView
//  无线轮播 任何问题可以前往留言

#import <Foundation/Foundation.h>

@interface SXLinkList : NSObject
@property(nonatomic, assign) NSInteger index;
@property(nonatomic, strong) id data;
@property(nonatomic, strong) SXLinkList *next;
@property(nonatomic, strong) SXLinkList *last;

+ (SXLinkList *)createLinkList;

+ (SXLinkList *)createLinkListWithURLsArray:(NSArray *)urlArr;
@end
