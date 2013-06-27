//
//  OverviewViewController.h
//  Terminal Map 3
//
//  Created by Jennifer Duffey on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewStackController : UIViewController
<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *menuTableView;
@property (nonatomic, strong) NSDictionary *menuItems;
@property (nonatomic, strong) NSArray *menuTitles;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, strong) UINavigationController *contentNavController;

- (IBAction)revealMenu:(id)sender;
- (IBAction)goBack:(id)sender;

@end
