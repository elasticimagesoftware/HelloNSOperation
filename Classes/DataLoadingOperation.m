//
//  DataLoadingOperation.m
//  LazyLoadingScrollView
//
//  Created by turner on 10/2/09.
//  Copyright 2009 Douglass Turner Consulting. All rights reserved.
//

#import "DataLoadingOperation.h"

@implementation DataLoadingOperation

- (void)dealloc {
	
    [_requestPackage	release];
    [super				dealloc];
}

- (id)initWithDataRequestPackage:(NSDictionary *)requestPackage target:(id)target action:(SEL)action {
	
    self = [super init];
	
    if (self) {
		
        _requestPackage	= [requestPackage retain];		
        _target			= target;
        _action			= action;
    }
	
    return self;
}

- (void)main {

	NSString *daturnerURL	= @"http://www.daturner.com/hellonsoperation/pig.m4a";
	NSURL *sequenceDataURL	= [NSURL URLWithString:daturnerURL];
	
	NSMutableData *mutableData = [[[NSMutableData alloc] initWithContentsOfURL:sequenceDataURL] autorelease];

	NSLog(@"Data LoadingOperation - %d", [mutableData length]);
	
	NSDictionary *result = [NSDictionary dictionaryWithObjectsAndKeys:
							mutableData, @"data", 
							nil];
	
	[_target performSelectorOnMainThread:_action withObject:result waitUntilDone:NO];
   
}

@end
