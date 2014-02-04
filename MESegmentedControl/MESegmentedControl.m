#import "MESegmentedControl.h"
#import "CustomBadge.h"

//
//  MESegmentedControl.m
//
//  Created by David Thompson on 21/05/2012.
//  Copyright (c) 2012 David Thompson. All rights reserved.
//

// taken from CustomBadge; it would be nicer to have this defined in CustomBadge and included of course
#define kCustomBadgeWidth (25)

@implementation MESegmentedControl

// Make an even distribution of space between labels, allowing one badge width per label.
-(void)resizeSegmentsToFitTitles {
  
  CGFloat originalWidth = self.bounds.size.width;
  
  // this may not be the exact font used in the label but the proportion, not the exact measurement, matters
  UIFont* segmentFont = [UIFont systemFontOfSize:[UIFont labelFontSize]];

  NSInteger numberOfSegments = [self numberOfSegments];
  NSInteger index;
  NSMutableArray *labelWidths = [NSMutableArray arrayWithCapacity:numberOfSegments];
  CGFloat totalWidth = 0;
  
  // adding badge width to both totals and labels and then calculating proportions decreases error
  for(index = 0; index < numberOfSegments; index++) {
    NSString *labelString = [self titleForSegmentAtIndex:index];
    CGFloat labelWidth = [labelString sizeWithFont:segmentFont].width;
    totalWidth += labelWidth + kCustomBadgeWidth;
    [labelWidths addObject:[NSNumber numberWithFloat:labelWidth]];
  }
  
  for(index = 0; index < numberOfSegments; index++) {
    CGFloat measuredWidth = [[labelWidths objectAtIndex:index] floatValue];
    CGFloat calculatedWidth = floor(originalWidth * (measuredWidth + kCustomBadgeWidth) / totalWidth);
    [self setWidth:calculatedWidth forSegmentAtIndex:index];
  }
}

- (void)setBadgeNumber:(NSUInteger)badgeNumber forSegmentAtIndex:(NSUInteger)segmentIndex usingBlock:(void(^)(CustomBadge *))configureBadge{
    // If this is the first time a badge number has been set, then initialise the segment widths and badges
    if (_segmentBadgeNumbers.count == 0)
    {
      // to size segments correctly (leaving room for badges, not overlapping labels) the segment sizes must be
      // calculated manually. If not, widthForSegmentAtIndex: returns 0 and badge position can't be set accurately
      // (it would be best to override setTitle:forSegmentAtIndex: and related methods but this is easier for now)
      [self resizeSegmentsToFitTitles];
      
        //initialise the badge arrays
        _segmentBadgeNumbers = [NSMutableArray arrayWithCapacity:self.numberOfSegments];
        _segmentBadges = [NSMutableArray arrayWithCapacity:self.numberOfSegments];
        for (int index = 0; index < self.numberOfSegments; index++)
        {
            [_segmentBadgeNumbers addObject:[NSNumber numberWithInt:0]];
            [_segmentBadges addObject:[NSNull null]];
        }
        
        // Create a transparent view to go on top of the segmented control and to hold the badges. (This transparent view is added to the superview to work around strange UISegmentedControl behaviour which causes its own subviews to be obscured when certain segments are selected. It's important then that the MESegmentedControl is placed on top of a suitable view and not directly onto a UINavigationItem.)
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
      CGFloat rightEdgeOfSegment = 0;
      for(int i = 0; i <= segmentIndex; i++) {
        rightEdgeOfSegment += [self widthForSegmentAtIndex:i];
      }
        CustomBadge *customBadge = [CustomBadge customBadgeWithString:[NSString stringWithFormat:@"%d", badgeNumber]];
        [customBadge setFrame:CGRectMake(rightEdgeOfSegment - (2 * customBadge.frame.size.width / 3),
                                         -5,
                                         customBadge.frame.size.width,
                                         customBadge.frame.size.height)];
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
    
    // Yield to the block for any custom setup to be done on the badge
    if (badgeNumber > 0)
    {
        configureBadge([_segmentBadges objectAtIndex:segmentIndex]);
    }
}

- (void)setBadgeNumber:(NSUInteger)badgeNumber forSegmentAtIndex:(NSUInteger)segmentIndex
{
    [self setBadgeNumber:badgeNumber forSegmentAtIndex:segmentIndex usingBlock:^(CustomBadge *badge){}];
}

- (NSUInteger)getBadgeNumberForSegmentAtIndex:(NSUInteger)segmentIndex
{
    if(_segmentBadgeNumbers==nil)
    {
        return 0;
    }
    NSNumber* number=[_segmentBadgeNumbers objectAtIndex:segmentIndex];
    if(number==nil)
    {
        return 0;
    }
    else
    {
        return [number unsignedIntegerValue];
    }
}

- (void)clearBadges
{
    // Remove the badge view
    [_badgeView removeFromSuperview];
    
    // Clear the badge arrays
    [_segmentBadges removeAllObjects];
    [_segmentBadgeNumbers removeAllObjects];
}

-(void)removeFromSuperview
{
    if (_badgeView) [_badgeView removeFromSuperview];
    [super removeFromSuperview];
}

-(void)dealloc
{
    if (_badgeView) [_badgeView removeFromSuperview];
}

@end
