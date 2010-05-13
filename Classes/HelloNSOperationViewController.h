//
//  HelloNSOperationViewController.h
//  HelloNSOperation
//
//  Created by Douglass Turner on 5/12/10.
//  Copyright Elastic Image Software LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelloNSOperationViewController : UIViewController {
	
	UILabel						*m_label;
	UIActivityIndicatorView		*m_spinner;
	
	NSRange					m_basepairRange;
	
    NSMutableData			*m_sequenceData;
    NSString				*m_sequenceString;	
	NSOperationQueue		*m_operationQueue;
}

@property(nonatomic,retain)IBOutlet UILabel *label;
@property(nonatomic,retain)IBOutlet UIActivityIndicatorView *spinner;

@property(nonatomic,assign)NSRange basepairRange;
@property(nonatomic,retain)NSMutableData *sequenceData;
@property(nonatomic,retain)NSString *sequenceString;
@property(nonatomic,retain)NSOperationQueue *operationQueue;

-(IBAction) triggerSequenceDataLoadingOperation:(id)sender;

@end

