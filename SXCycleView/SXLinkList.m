//
//  SXLinkList.m
//  test
//
//  Created by xiaoR
//  github地址:https://github.com/poos/SXCycleView
//  无线轮播 任何问题可以前往留言

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
