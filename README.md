Introduction
=========================

MESegmentedControl is an enhanced UISegmentedControl which allows you to set badge numbers on each of the control's segments, like so:

![First Screnshot](/dave-thompson/MESegmentedControl/raw/master/SampleScreenShot.png)

Installation
-------------------------

1. Copy the following files from the MESegmentedControl directory into your project. Link them to your target.
    1. **MESegmentedControl.h** 
    1. **MESegmentedControl.m**
    1. **CustomBadge.h**
    1. **CustomBadge.m**
1. _MESegmentedControl should use ARC but CustomBadge should not._ So if your project **_does_** use ARC, set the compiler flag `-fno-objc-arc` for the CustomBadge.m source within your target. If your project **_doesn't_** use ARC, set the compiler flag `-fobjc-arc` for the MESegmentedControl.m source within your target. See illustrated instructions [here](http://www.leesilver.net/1/post/2011/8/disabling-arc-on-certain-files-in-xcode.html).


Usage
-------------------------

1. Within your application, replace instances of UISegmentedControl with MESegmentedControl.
1. Set badge numbers using, e.g. `[segmentedControl setBadgeNumber:1 forSegmentAtIndex:0]`. Set a badge number to 0 to remove the badge. Assign custom colours to badges using blocks - see [MEViewController.m](/dave-thompson/MESegmentedControl/blob/master/MESegmentedControl/MEViewController.m).
1. Get current badge numbers using, e.g. `[segmentedControl getBadgeNumberForSegmentAtIndex:0]`.
1. Consider setting your badge numbers in your view controller's viewWillAppear method and clearing them using `[segmentedControl clearBadges]` in viewDidDisappear.
1. _MESegmentedControl should not be placed directly on a UINavigationItem due to issues during push / pop transitions._ If you wish to use MESegmentedControl within a UINavigationItem (as in the screenshot above), then do not do so directly. Instead, place a transparent UIView onto the UINavigationItem and place the MESegmentedControl onto the transparent UIView.
1. If you need to add or remove segments after adding your first badge, then call `[segmentedControl clearBadges]` beforehand. _It's not sufficient here to simply set your badges to zero._

Open the included XCode project to see a sample app.

Limitations
-------------------------

* Segments must each be the same size.
* Badges can only take positive integer values.

Neither of these limitations are inherent to the platform: they may be resolved with straightforward enhancements to the library.

License
-------------------------

MESegmentedControl is distributed under the Modified BSD License.

Credits
-------------------------

* MESegmentedControl was written by Dave Thompson.
* The CustomBadge component was written by Sascha Paulus. See  [Sascha's blog](http://www.spaulus.com/2011/04/custombadge-2-0-retina-ready-scalable-light-reflex/?lang=en).