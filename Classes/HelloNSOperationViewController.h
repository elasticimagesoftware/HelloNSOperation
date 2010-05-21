//
//  HelloNSOperationViewController.h
//  HelloNSOperation
//
//  Created by Douglass Turner on 5/12/10.
//  Copyright Elastic Image Software LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Counter;
@class Observer;

@interface HelloNSOperationViewController : UIViewController {
	
	// Data fetch GUI
	UILabel						*m_label;
	UIActivityIndicatorView		*m_spinner;
	
	NSRange					m_basepairRange;
	
    NSMutableData			*m_sequenceData;
    NSString				*m_sequenceString;	
	NSOperationQueue		*m_operationQueue;

	Counter					*m_counter;
	Observer				*m_observer;
	
	// Slider GUI
	UISlider				*m_slider;
	UILabel					*m_sliderLabel;
	
	
}

@property(nonatomic,retain)IBOutlet UILabel *label;
@property(nonatomic,retain)IBOutlet UIActivityIndicatorView *spinner;

@property(nonatomic,assign)NSRange basepairRange;
@property(nonatomic,retain)NSMutableData *sequenceData;
@property(nonatomic,retain)NSString *sequenceString;
@property(nonatomic,retain)NSOperationQueue *operationQueue;

@property(nonatomic,retain)IBOutlet UISlider *slider;
@property(nonatomic,retain)IBOutlet UILabel *sliderLabel;
@property(nonatomic,retain) IBOutlet Counter	*counter;

@property(nonatomic,retain)Observer *observer;

-(IBAction) triggerSequenceDataLoadingOperation:(id)sender;

-(void) updateSliderLabel:(NSNumber *)newValue;

@end

