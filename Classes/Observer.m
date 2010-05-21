//
//  Observer.m
//  HelloKVO
//
//  Created by Douglass Turner on 5/10/10.
//  Copyright 2010 Elastic Image Software LLC. All rights reserved.
//

#import "Observer.h"

@implementation Observer

@synthesize targetObject = m_targetObject;
@synthesize targetAction = m_targetAction;

- (void)dealloc {
	
	[m_targetObject release], m_targetObject = nil;
	
	[super dealloc];
}

-(id) initWithTarget:(id)object action:(SEL)action {
	
    if (self = [super init]) {
		
        self.targetObject = object;
        self.targetAction = action;
		
    } // if (self = [super init])
	
    return self;
}     

- (void)observeValueForKeyPath:(NSString *)keyPath 
					  ofObject:(id)object 
						change:(NSDictionary *)change 
					   context:(void *)context {
	
	NSLog(@"Observer - observeValueForKeyPath: %@ forObject: %@", keyPath, [object class]);
	NSLog(@"Observer - On %@ performSelector: %@ withObject: %@ = %@", 
		  NSStringFromClass([self.targetObject class]),
		  NSStringFromSelector(self.targetAction), NSStringFromClass([[object valueForKeyPath:keyPath] class]), [object valueForKeyPath:keyPath]);
	
    [self.targetObject performSelector:self.targetAction withObject:[object valueForKeyPath:keyPath]];
	
}

@end
