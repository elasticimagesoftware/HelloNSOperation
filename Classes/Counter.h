//
//  Counter.h
//  HelloKVO
//
//  Created by Douglass Turner on 5/10/10.
//  Copyright 2010 Elastic Image Software LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Counter : NSObject {
    NSNumber *count;
}

@property(nonatomic, retain) NSNumber *count;

-(IBAction) trackSlider:(UISlider *)slider;

@end
