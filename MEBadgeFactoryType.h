//
//  MEBadgeFactoryType.h
//  
//
//  Created by Victor Shamanov on 8/11/15.
//
//

#import <Foundation/Foundation.h>
#import "MEBadgeType.h"

@protocol MEBadgeFactoryType <NSObject>

- (id <MEBadgeType>)customBadgeWithString:(NSString *)string;

@end
