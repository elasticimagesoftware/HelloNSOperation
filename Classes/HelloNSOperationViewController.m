//
//  HelloNSOperationViewController.m
//  HelloNSOperation
//
//  Created by Douglass Turner on 5/12/10.
//  Copyright Elastic Image Software LLC 2010. All rights reserved.
//

#import "HelloNSOperationViewController.h"
#import "DataLoadingOperation.h"
#import "Counter.h"
#import "Observer.h"

@implementation HelloNSOperationViewController

@synthesize label = m_label;
@synthesize spinner = m_spinner;

@synthesize data = m_data;
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
	
    [m_data				release];
    m_data				= nil;
	
    [m_operationQueue	release];
	m_operationQueue	= nil;
	
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

- (void)didFinishRetrievingData:(NSDictionary *)results {
	
	self.data			= [results objectForKey:@"data"];
	self.label.text		= [NSString stringWithFormat:@"%d MB", [self.data length]/1000000];
	
	[self.spinner stopAnimating];
	
}

#pragma mark -
#pragma mark HelloNSOperationViewController Public Methods

-(IBAction) triggerDataLoadingOperation:(id)sender {

	NSLog(@"Hello NSOperation ViewController - trigger Data LoadingOperation");

	self.label.text = @"";

	self.operationQueue = [[[NSOperationQueue alloc] init] autorelease];
	[self.operationQueue setMaxConcurrentOperationCount:1];
	
	SEL theAction = @selector(didFinishRetrievingData:);

	NSDictionary *requestPackage = 
	[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithString:@"nuthin" ], @"nothing_to_see_move_along", nil];
	
	DataLoadingOperation *operation = 
	[[[DataLoadingOperation alloc] initWithDataRequestPackage:requestPackage 
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
