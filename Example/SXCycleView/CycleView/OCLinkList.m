//
//  OCLinkList.m
//  test
//
//  Created by n369 on 16/8/11.
//  Copyright © 2016年 n369. All rights reserved.
//

#import "OCLinkList.h"

@implementation OCLinkList

+ (OCLinkList *)createLinkList {
    OCLinkList *head = [[OCLinkList alloc] init];
    head.data = [NSNumber numberWithInt:0];
    OCLinkList *ptr = head;
    for (int i=1; i<10; i++){
        OCLinkList *node = [[OCLinkList alloc] init];
        node.data = [NSNumber numberWithInt:i];
        ptr.next = node;
        node.last = ptr;
        ptr = node;
    }
    head.last = ptr;
    ptr.next = head;
    return head;
}

+ (OCLinkList *)createLinkListWithURLsArray:(NSArray *)urlArr {
    OCLinkList *head = [[OCLinkList alloc] init];
    head.data = [urlArr firstObject];
    head.index = 0;
    OCLinkList *ptr = head;
    for (int i=1; i<urlArr.count; i++){
        OCLinkList *node = [[OCLinkList alloc] init];
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
