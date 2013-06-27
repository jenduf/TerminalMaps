//
//  MapCell.m
//  TerminalMaps
//
//  Created by Jennifer Duffey on 6/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AirportCell.h"
#import "MapDownloadView.h"

@implementation AirportCell
@synthesize airportCode = _airportCode;
@synthesize airportName = _airportName;
@synthesize airportCity = _airportCity;
@synthesize downloadView = _downloadView;
@synthesize normalView = _normalView;
@synthesize downloadButton = _downloadButton;
@synthesize showDownload = _showDownload;
@synthesize delegate = _delegate;
@synthesize backgroundImage = _backgroundImage;

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	
	if(self)
	{
		
	}
	
	return self;
}

- (void)setUpCellWithOptions:(AirportCellOptions)opt
{
	UIImage *cellImage;
	
	switch(opt)
	{
		case AirportCellOptionsNone:
			cellImage = [UIImage imageNamed:IMAGE_CELL_BACKGROUND];
			[self.downloadButton setHidden:YES];
			break;
			
		case AirportCellOptionsSync:
			cellImage = [UIImage imageNamed:IMAGE_CELL_BACKGROUND_SEGMENTED];
			[self.downloadButton setBackgroundImage:[UIImage imageNamed:IMAGE_SYNC_BUTTON] forState:UIControlStateNormal];
			break;
			
		case AirportCellOptionsDownload:
			cellImage = [UIImage imageNamed:IMAGE_CELL_BACKGROUND_SEGMENTED];
			[self.downloadButton setBackgroundImage:[UIImage imageNamed:IMAGE_DOWNLOAD_BUTTON] forState:UIControlStateNormal];
			break;
	}
	
	self.backgroundImage.image = cellImage;
	
	
	//	self.normalView = [[UIImageView alloc] initWithImage:cellImage];
	//[self.contentView insertSubview:self.normalView atIndex:0];
}

- (IBAction)download:(id)sender
{
	//[self setFrame:CGRectMake(0, 0, 320, 93)];
	[self.delegate airportCellDidRequestShowDownload:self];
}

- (void)drawRect:(CGRect)rect
{
	if(self.showDownload == YES)
	{
		[self.contentView addSubview:self.downloadView];
		[self.downloadView setFrame:CGRectMake(0, AIRPORT_CELL_HEIGHT - 5, self.frame.size.width, AIRPORT_CELL_HEIGHT)];
		//[self insertSubview:downloadView atIndex:0];
		//UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
		//[button addTarget:self action:@selector(updateMap:) forControlEvents:UIControlEventTouchUpInside];
		//[self addSubview:button];
	}
	else
	{
		[self.downloadView removeFromSuperview];
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
