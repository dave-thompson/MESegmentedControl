Introduction
=========================

MESegmentedControl is an enhanced UISegmentedControl which allows you to set badge numbers on each of the controls' segments, like so:

![MESegmentedControl Example](/dave-thompson/MESegmentedControl/blob/master/SampleScreenShot.png)

Instructions
-------------------------

1. Copy the following files from MESegmentedControl directory into your project. Link them to your target.
    1. **MESegmentedControl.h**
    1. **MESegmentedControl.m**
    1. **CustomBadge.h**
    1. **CustomBadge.m**
1. _MESegmentedControl should use ARC but CustomBadge should not._ Therefore, assuming your project is set up for ARC, add the compiler flag -fno-objc-arc to the CustomBadge.m source within your target. See illustrated instructions [here](http://www.leesilver.net/1/post/2011/8/disabling-arc-on-certain-files-in-xcode.html).
1. Use MESegmentedControl in place of UISegmentedControl within your application.
1. Set badge numbers using `[segmentedControl setBadgeNumber:1 forSegmentAtIndex:0];`

Open the included XCode project to see a sample app.

Limitations
-------------------------

* Segments must each be the same size.
* Number of segments must not be changed after the first badge number is set.
* Badges can only take positive integer values.

None of these limitations are inherent to the platform: they may be resolved with straightforward enhancements to the library.

License
-------------------------

This is distributed under the Modified BSD License.

Credits
-------------------------

* MESegmentedControl was written by Dave Thompson.
* The CustomBadge component was written by Sascha Paulus. See  [Sascha's blog](http://www.spaulus.com/2011/04/custombadge-2-0-retina-ready-scalable-light-reflex/?lang=en).