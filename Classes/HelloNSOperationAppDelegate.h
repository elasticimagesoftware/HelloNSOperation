//
//  HelloNSOperationAppDelegate.h
//  HelloNSOperation
//
//  Created by Douglass Turner on 5/12/10.
//  Copyright Elastic Image Software LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HelloNSOperationViewController;

@interface HelloNSOperationAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    HelloNSOperationViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet HelloNSOperationViewController *viewController;

@end

