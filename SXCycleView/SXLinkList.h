//
//  SXLinkList.h
//  test
//
//  Created by n369 on 16/8/11.
//  Copyright © 2016年 n369. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXLinkList : NSObject
@property(nonatomic, assign) NSInteger index;
@property(nonatomic, strong) id data;
@property(nonatomic, strong) SXLinkList *next;
@property(nonatomic, strong) SXLinkList *last;

+ (SXLinkList *)createLinkList;

+ (SXLinkList *)createLinkListWithURLsArray:(NSArray *)urlArr;
@end
