//
//  HelloNSOperationViewController.m
//  HelloNSOperation
//
//  Created by Douglass Turner on 5/12/10.
//  Copyright Elastic Image Software LLC 2010. All rights reserved.
//

#import "HelloNSOperationViewController.h"
#import "SequenceDataLoadingOperation.h"
#import "Counter.h"
#import "Observer.h"

@implementation HelloNSOperationViewController

@synthesize label = m_label;
@synthesize spinner = m_spinner;

@synthesize basepairRange = m_basepairRange;
@synthesize sequenceData = m_sequenceData;
@synthesize sequenceString = m_sequenceString;
@synthesize operationQueue = m_operationQueue;

@synthesize slider = m_slider;
@synthesize sliderLabel = m_sliderLabel;
@synthesize counter = m_counter;
@synthesize observer = m_observer;

- (void)dealloc {
	
    [m_label release], m_label = nil;
    [m_spinner release], m_spinner = nil;
	
    self.label = nil;
    self.spinner = nil;

	[m_slider release], m_slider = nil;
    [m_sliderLabel release], m_sliderLabel = nil;
	
    self.slider = nil;
	self.sliderLabel = nil;
	
    [m_counter release], m_counter = nil;
    [m_observer release], m_observer = nil;
	
	[m_sequenceData release], m_sequenceData = nil;
    [m_sequenceString release], m_sequenceString = nil;
    [m_operationQueue release], m_operationQueue = nil;
	
    [super dealloc];
}

#pragma mark -
#pragma mark HelloNSOperationViewController View Lifecycle Methods

- (void)viewDidLoad {
	
	NSLog(@"Hello NSOperation ViewController - view Did Load");
	
    [super viewDidLoad];

	self.label.text = @"";

	self.observer = [[[Observer alloc] initWithTarget:self action:@selector(updateSliderLabel:)] autorelease];
	
	[self.counter addObserver:self.observer forKeyPath:@"count" options:NSKeyValueObservingOptionNew context:NULL];	
	
}

#pragma mark -
#pragma mark HelloNSOperationViewController Private Methods

- (void)didFinishRetrievingSequenceData:(NSDictionary *)results {
	
	self.sequenceData		= [results objectForKey:@"sequenceData"];
	self.sequenceString		= [
							   [[NSString alloc] initWithBytes:[self.sequenceData bytes] 
													 length:[self.sequenceData length] 
												   encoding:NSUTF8StringEncoding] 
							   autorelease];
	
	NSUInteger location	= [[results objectForKey:@"basepairStart"] intValue];
	NSUInteger length	= [[results objectForKey:@"basepairEnd"  ] intValue] - location;
	self.basepairRange	= NSMakeRange(location, length);
	
	self.label.text = [NSString stringWithFormat:@"%d MB", [self.sequenceData length]/1000000];
	
	[self.spinner stopAnimating];
	
}

#pragma mark -
#pragma mark HelloNSOperationViewController Public Methods

-(IBAction) triggerSequenceDataLoadingOperation:(id)sender {

	NSLog(@"Hello NSOperation ViewController - trigger SequenceData LoadingOperation");

	self.label.text = @"";

	self.operationQueue = [[[NSOperationQueue alloc] init] autorelease];
	[self.operationQueue setMaxConcurrentOperationCount:1];
	
	self.basepairRange = NSMakeRange((NSUInteger)1e6, (NSUInteger)(8e6 - 1));
	
	NSInteger theStart = self.basepairRange.location;
	NSInteger theEnd = (self.basepairRange.length + self.basepairRange.location);

	SEL theAction = @selector(didFinishRetrievingSequenceData:);

	NSDictionary *requestPackage = [NSDictionary dictionaryWithObjectsAndKeys:
									[NSString stringWithString:@"1" ],	@"chromosome",
									[NSNumber numberWithInt:theStart],	@"basepairStart",
									[NSNumber numberWithInt:theEnd  ],	@"basepairEnd",
									nil];
	
	SequenceDataLoadingOperation *operation = 
	[[[SequenceDataLoadingOperation alloc]initWithSequenceDataRequestPackage:requestPackage 
																	  target:self 
																	  action:theAction] autorelease];
	
	[self.spinner startAnimating];
	
	[self.operationQueue addOperation:operation];
		
}

-(void) updateSliderLabel:(NSNumber *)newValue {
	
	NSLog(@"Hello NSOperation ViewController - updateLabel: %@", newValue);
	
	self.sliderLabel.text = [NSString stringWithFormat:@"%.0f", [newValue floatValue]];
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
	
}

@end
