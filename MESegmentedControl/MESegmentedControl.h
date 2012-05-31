//
//  MESegmentedControl.h
//
//  Created by David Thompson on 21/05/2012.
//  Copyright (c) 2012 David Thompson. All rights reserved.
//

@class CustomBadge;

@interface MESegmentedControl : UISegmentedControl
{
@private
	NSMutableArray *_segmentBadgeNumbers;
	NSMutableArray *_segmentBadges;
    UIView *_badgeView;
}

// Gets the badge number for a specific segment.
- (NSUInteger)getBadgeNumberForSegmentAtIndex:(NSUInteger)segmentIndex;

// Set the badge number for a specific segment.
// Setting the badge number to 0 will clear the badge for that segment.
// Use the block to make adjustments to badge formatting, using the methods outlined in CustomBadge.h.
- (void)setBadgeNumber:(NSUInteger)badgeNumber forSegmentAtIndex:(NSUInteger)segmentIndex usingBlock:(void(^)(CustomBadge *))configureBadge;

// Convenience method for setting a badge number with default look and feel
- (void)setBadgeNumber:(NSUInteger)badgeNumber forSegmentAtIndex:(NSUInteger)segmentIndex;

// Clear badges across all segments.
// If you need to add or remove segments
- (void)clearBadges;

@end
