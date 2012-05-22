#import "MESegmentedControl.h"
#import "CustomBadge.h"

//
//  MESegmentedControl.m
//
//  Created by David Thompson on 21/05/2012.
//  Copyright (c) 2012 David Thompson. All rights reserved.
//

@implementation MESegmentedControl

- (void)setBadgeNumber:(NSUInteger)badgeNumber forSegmentAtIndex:(NSUInteger)segmentIndex
{
    // If this is the first time a badge number has been set, then initialise
    if (_segmentBadgeNumbers.count == 0)
    {
        //initialise the badge arrays
        _segmentBadgeNumbers = [NSMutableArray arrayWithCapacity:self.numberOfSegments];
        _segmentBadges = [NSMutableArray arrayWithCapacity:self.numberOfSegments];
        for (int index = 0; index < self.numberOfSegments; index++)
        {
            [_segmentBadgeNumbers addObject:[NSNumber numberWithInt:0]];
            [_segmentBadges addObject:[NSNull null]];
        }
        
        // add a transparent view on top of the segmented control to hold the badges
        // (this transparent view is added to the superview to work around stange UISegmentedControl behaviour which causes its own subviews to be obscured when certain segments are selected)
        _badgeView = [[UIView alloc] initWithFrame:self.frame];
        [_badgeView setBackgroundColor:[UIColor clearColor]];
        _badgeView.userInteractionEnabled = NO;
        [self.superview addSubview:_badgeView];
    }
    
    // Recall the old badge number and store the new badge number
    int oldBadgeNumber = ((NSNumber *)[_segmentBadgeNumbers objectAtIndex:segmentIndex]).intValue;
    [_segmentBadgeNumbers replaceObjectAtIndex:segmentIndex withObject:[NSNumber numberWithUnsignedInteger:badgeNumber]];
    
    // Modify the badge view
    if ((oldBadgeNumber == 0) && (badgeNumber > 0))
    {
        // Add a badge, positioned on the upper right side of the requested segment
        // (Assumes that all segments are the same size - if segments are of different sizes, modify the below to use the widthForSegmentAtIndex method on UISegmentedControl)
        CustomBadge *customBadge = [CustomBadge customBadgeWithString:[NSString stringWithFormat:@"%d", badgeNumber]];
        // CHANGE THE BADGE'S LOOK & FEEL HERE IF DESIRED - SEE THE METHODS IN CUSTOMBADGE.H
        // eg. customBadge.badgeInsetColor = [UIColor greenColor];
        [customBadge setFrame:CGRectMake(((self.frame.size.width/self.numberOfSegments)* (segmentIndex + 1))-customBadge.frame.size.width +5, -5, customBadge.frame.size.width, customBadge.frame.size.height)];
        [_segmentBadges replaceObjectAtIndex:segmentIndex withObject:customBadge];
        [_badgeView addSubview:customBadge];
    }
    else if ((oldBadgeNumber > 0) && (badgeNumber == 0))
    {
        // Remove the badge
        [[_segmentBadges objectAtIndex:segmentIndex] removeFromSuperview];
        [_segmentBadges replaceObjectAtIndex:segmentIndex withObject:[NSNull null]];
    }
    else if ((oldBadgeNumber != badgeNumber) && (badgeNumber > 0))
    {
        // Update the number on the existing badge
        [[_segmentBadges objectAtIndex:segmentIndex] autoBadgeSizeWithString:[NSString stringWithFormat:@"%d", badgeNumber]];
    }    
}

-(void)removeFromSuperview
{
    if (_badgeView) [_badgeView removeFromSuperview];
    [super removeFromSuperview];
}

// Note: This subclass does not handle the case where a UISegmentedControl's items are changed after instantiation.
//       To handle this, also override the following methods on UISegmentedControl.
/*
 - (void)insertSegmentWithTitle:(NSString *)title atIndex:(NSUInteger)segment animated:(BOOL)animated; // insert before segment number. 0..#segments. value pinned
 - (void)insertSegmentWithImage:(UIImage *)image  atIndex:(NSUInteger)segment animated:(BOOL)animated;
 - (void)removeSegmentAtIndex:(NSUInteger)segment animated:(BOOL)animated;
 - (void)removeAllSegments;
*/
         
@end
