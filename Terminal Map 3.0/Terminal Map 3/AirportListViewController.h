//
//  AirportListViewController.h
//  Terminal Map 3
//
//  Created by Jennifer Duffey on 1/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AirportCell.h"

@interface AirportListViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource, AirportCellDelegate>

@property (nonatomic, strong) IBOutlet UITableView *airportTableView;
@property (nonatomic, strong) NSMutableArray *airportList;

- (void)sortAirports;

@end
