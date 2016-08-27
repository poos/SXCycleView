//
//  SXLinkList.m
//  test
//
//  Created by n369 on 16/8/11.
//  Copyright © 2016年 n369. All rights reserved.
//

#import "SXLinkList.h"

@implementation SXLinkList

+ (SXLinkList *)createLinkList {
    SXLinkList *head = [[SXLinkList alloc] init];
    head.data = [NSNumber numberWithInt:0];
    SXLinkList *ptr = head;
    for (int i=1; i<10; i++){
        SXLinkList *node = [[SXLinkList alloc] init];
        node.data = [NSNumber numberWithInt:i];
        ptr.next = node;
        node.last = ptr;
        ptr = node;
    }
    head.last = ptr;
    ptr.next = head;
    return head;
}

+ (SXLinkList *)createLinkListWithURLsArray:(NSArray *)urlArr {
    SXLinkList *head = [[SXLinkList alloc] init];
    head.data = [urlArr firstObject];
    head.index = 0;
    SXLinkList *ptr = head;
    for (int i=1; i<urlArr.count; i++){
        SXLinkList *node = [[SXLinkList alloc] init];
        node.index = i;
        node.data = [urlArr objectAtIndex:i];
        ptr.next = node;
        node.last = ptr;
        ptr = node;
    }
    head.last = ptr;
    ptr.next = head;
    return head;
}

@end
