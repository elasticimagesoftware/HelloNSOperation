//
//  Counter.m
//  HelloKVO
//
//  Created by Douglass Turner on 5/10/10.
//  Copyright 2010 Elastic Image Software LLC. All rights reserved.
//

#import "Counter.h"

@implementation Counter

@synthesize count;

- (void)dealloc {
	
    [count release], count = nil;
	
	[super dealloc];
}

-(IBAction) trackSlider:(UISlider *)slider; {
	
    self.count = [NSNumber numberWithFloat:slider.value];
		
}

@end
