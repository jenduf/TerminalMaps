//
//  MapCell.h
//  TerminalMaps
//
//  Created by Jennifer Duffey on 6/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@protocol AirportCellDelegate; 

@class MapDownloadView;
@interface AirportCell : UITableViewCell 
{
    
}

@property (nonatomic, strong) IBOutlet UILabel *airportCode, *airportName, *airportCity;
@property (nonatomic, strong) IBOutlet MapDownloadView *downloadView;
@property (nonatomic, strong) IBOutlet UIButton *downloadButton;
@property (nonatomic, assign) BOOL showDownload;
@property (nonatomic, strong) UIImageView *normalView;
@property (nonatomic, strong) id <AirportCellDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;

- (IBAction)download:(id)sender;
- (void)setUpCellWithOptions:(AirportCellOptions)opt;

@end

@protocol AirportCellDelegate
@optional
- (void)airportCellDidRequestShowDownload:(AirportCell *)cell;
@end


