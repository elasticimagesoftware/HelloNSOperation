//
//  HelloNSOperationViewController.m
//  HelloNSOperation
//
//  Created by Douglass Turner on 5/12/10.
//  Copyright Elastic Image Software LLC 2010. All rights reserved.
//

#import "HelloNSOperationViewController.h"
#import "SequenceDataLoadingOperation.h"

@implementation HelloNSOperationViewController

@synthesize label = m_label;
@synthesize spinner = m_spinner;

@synthesize basepairRange = m_basepairRange;
@synthesize sequenceData = m_sequenceData;
@synthesize sequenceString = m_sequenceString;
@synthesize operationQueue = m_operationQueue;

- (void)dealloc {
	
    [m_label release], m_label = nil;
    [m_spinner release], m_spinner = nil;
	
    self.label = nil;
    self.spinner = nil;

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
	
}

#pragma mark -
#pragma mark HelloNSOperationViewController Private Methods

- (void)didFinishRetrievingSequenceData:(NSDictionary *)results {
	
	self.sequenceData		= [results objectForKey:@"sequenceData"];
	self.sequenceString		= [[[NSString alloc] initWithBytes:[self.sequenceData bytes] length:[self.sequenceData length] encoding:NSUTF8StringEncoding] autorelease];
	
	NSUInteger location	= [[results objectForKey:@"basepairStart"] intValue];
	NSUInteger length	= [[results objectForKey:@"basepairEnd"  ] intValue] - location;
	self.basepairRange	= NSMakeRange(location, length);
	
	self.label.text = [NSString stringWithFormat:@"%d bytes", [self.sequenceData length]];
	
	[self.spinner stopAnimating];
	
}

#pragma mark -
#pragma mark HelloNSOperationViewController Public Methods

-(IBAction) triggerSequenceDataLoadingOperation:(id)sender {

	NSLog(@"Hello NSOperation ViewController - trigger SequenceData LoadingOperation");

	self.label.text = @"";

	self.operationQueue = [[[NSOperationQueue alloc] init] autorelease];
	[self.operationQueue setMaxConcurrentOperationCount:1];
	
	self.basepairRange = NSMakeRange((NSUInteger)1e6, (NSUInteger)(2e6 - 1));
	
	NSDictionary *requestPackage = [NSDictionary dictionaryWithObjectsAndKeys:
									[NSString stringWithString:@"1"],													@"chromosome",
									[NSNumber numberWithInt:self.basepairRange.location],								@"basepairStart",
									[NSNumber numberWithInt:(self.basepairRange.length + self.basepairRange.location)],	@"basepairEnd",
									nil];
	
	SequenceDataLoadingOperation *operation = 
	[[[SequenceDataLoadingOperation alloc]initWithSequenceDataRequestPackage:requestPackage 
																	  target:self 
																	  action:@selector(didFinishRetrievingSequenceData:)] autorelease];
	
	[self.spinner startAnimating];
	
	[self.operationQueue addOperation:operation];
		
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
	
}

@end
