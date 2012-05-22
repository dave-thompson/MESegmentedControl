//
//  MESegmentedControl.h
//
//  Created by David Thompson on 21/05/2012.
//  Copyright (c) 2012 David Thompson. All rights reserved.
//

@interface MESegmentedControl : UISegmentedControl
{
    @private
	NSMutableArray *_segmentBadgeNumbers;
	NSMutableArray *_segmentBadges;
    UIView *_badgeView;
}

// Set the badge number for a specific segment.
// Setting the badge number to 0 will remove the badge for that segment.
- (void)setBadgeNumber:(NSUInteger)badgeNumber forSegmentAtIndex:(NSUInteger)segment;

@end
