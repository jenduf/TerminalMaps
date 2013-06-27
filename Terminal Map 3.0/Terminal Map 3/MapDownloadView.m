//
//  MapDownloadView.m
//  TerminalMaps
//
//  Created by Jennifer Duffey on 6/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapDownloadView.h"
#import "Constants.h"

@implementation MapDownloadView
@synthesize topLabel = _topLabel;
@synthesize bottomLabel = _bottomLabel;
@synthesize progressLabel = _progressLabel;
@synthesize progressContainerView = _progressContainerView;
@synthesize updateContainerView = _updateContainerView;
@synthesize progressView = _progressView;
@synthesize updateButton = _updateButton;
@synthesize cancelButton = _cancelButton;
@synthesize showProgress = _showProgress;

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	
	if(self)
	{

	}
	
	return self;
}

- (void)update:(id)sender
{
     [self.updateContainerView removeFromSuperview];
     [self addSubview:self.progressContainerView];
}

- (IBAction)cancel:(id)sender
{
     [self.progressContainerView removeFromSuperview];
     [self showUpdateView];
}

- (void)didMoveToSuperview
{
     [self showUpdateView];
}

- (void)showUpdateView
{
     UIImage *updateImg = [UIImage imageNamed:IMAGE_UPDATE_BUTTON];
     self.updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
     [self.updateButton setBackgroundImage:updateImg forState:UIControlStateNormal];
     [self.updateButton setFrame:CGRectMake(UPDATE_BUTTON_X, UPDATE_BUTTON_Y, updateImg.size.width, updateImg.size.height)];
     [self.updateButton addTarget:self action:@selector(update:) forControlEvents:UIControlEventTouchUpInside];
     [self.updateContainerView addSubview:self.updateButton];
     
     [self addSubview:self.updateContainerView];
}

@end
