//
//  SearchHistoryViewController.h
//  Terminal Map 3
//
//  Created by Jennifer Duffey on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchHistoryCollection.h"

@protocol SearchHistoryViewControllerDelegate;
@interface SearchHistoryViewController : UIViewController

@property (nonatomic, strong) SearchHistoryCollection *searchHistory;
@property (nonatomic, strong) IBOutlet UITableView *searchHistoryTableView;
@property (nonatomic, weak) id <SearchHistoryViewControllerDelegate> delegate;

- (IBAction)goBack:(id)sender;

@end

@protocol SearchHistoryViewControllerDelegate <NSObject>

- (void)searchHistoryViewController:(SearchHistoryViewController *)searchHistoryVC didSelectSearchData:(SearchHistoryData *)searchData;

@end
