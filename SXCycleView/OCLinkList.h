//
//  OCLinkList.h
//  test
//
//  Created by n369 on 16/8/11.
//  Copyright © 2016年 n369. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OCLinkList : NSObject
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) id data;
@property (nonatomic, strong) OCLinkList *next;
@property (nonatomic, strong) OCLinkList *last;

+ (OCLinkList *)createLinkList;

+ (OCLinkList *)createLinkListWithURLsArray:(NSArray *)urlArr;
@end
