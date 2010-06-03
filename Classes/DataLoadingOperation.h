//
//  DataLoadingOperation.h
//  LazyLoadingScrollView
//
//  Created by turner on 10/2/09.
//  Copyright 2009 Douglass Turner Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataLoadingOperation : NSOperation {
	
	NSDictionary *_requestPackage;
	
    id _target;
    SEL _action;
	
}

- (id)initWithDataRequestPackage:(NSDictionary *)requestPackage 
								  target:(id)target 
								  action:(SEL)action;

@end
