//
//  Observer.h
//  HelloKVO
//
//  Created by Douglass Turner on 5/10/10.
//  Copyright 2010 Elastic Image Software LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Observer : NSObject {
    id	m_targetObject;
    SEL	m_targetAction;
}

@property(nonatomic,retain)id targetObject;
@property(nonatomic,assign)SEL targetAction;

-(id) initWithTarget:(id)object action:(SEL)action;

@end
