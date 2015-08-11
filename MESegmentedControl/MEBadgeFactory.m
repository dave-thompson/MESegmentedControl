//
//  MEBadgeFactory.m
//  
//
//  Created by Victor Shamanov on 8/11/15.
//
//

#import "MEBadgeFactory.h"
#import "CustomBadge.h"

@implementation MEBadgeFactory

- (id<MEBadgeType>)customBadgeWithString:(NSString *)string {
    return [CustomBadge customBadgeWithString:string];
}

@end
