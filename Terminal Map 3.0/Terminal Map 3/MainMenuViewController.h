//
//  MainMenuViewController.h
//  Terminal Map 3
//
//  Created by Jennifer Duffey on 1/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "FontLabel.h"
#import "AirportCell.h"
#import "SearchHistoryCollection.h"
#import "SearchHistoryViewController.h"

@interface MainMenuViewController : UIViewController
<MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate, AirportCellDelegate, UISearchBarDelegate, SearchHistoryViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UIView *contentView;
@property (nonatomic, strong) IBOutlet UIImageView *tabSelectedImageView;
@property (nonatomic, strong) IBOutlet UITableView *mainTableView;
@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UISearchBar *airportSearchBar;
@property (nonatomic, strong) NSMutableArray *airportArray;
@property (strong, nonatomic) FontLabel *subHeaderLabel;
@property (strong, nonatomic) SearchHistoryCollection *searchHistory;
@property (nonatomic, assign) int previousSelectedIndex, currentViewIndex;

- (IBAction)tabSelected:(id)sender;
- (void)setUpAirportListWithData:(NSArray *)arr;
- (void)setUpFavoritesList;
- (void)filterContentForSearchText:(NSString *)searchText;

@end
