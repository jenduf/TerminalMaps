//
//  MainMenuViewController.m
//  Terminal Map 3
//
//  Created by Jennifer Duffey on 1/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainMenuViewController.h"
#import "Constants.h"
#import "AirportDB.h"
#import "MenuItem.h"
#import "Airport.h"
#import "SearchHistoryData.h"

@implementation MainMenuViewController
@synthesize contentView = _contentView;
@synthesize previousSelectedIndex = _previousSelectedIndex;
@synthesize currentViewIndex = _currentViewIndex;
@synthesize subHeaderLabel = _subHeaderLabel;
@synthesize tabSelectedImageView = _tabSelectedImageView;
@synthesize mainTableView = _mainTableView;
@synthesize mapView = _mapView;
@synthesize airportSearchBar = _airportSearchBar;
@synthesize airportArray = _airportArray;
@synthesize searchHistory = _searchHistory;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.subHeaderLabel = [[FontLabel alloc] initWithFrame:CGRectMake(0, self.tabSelectedImageView.frame.origin.y + VERTICAL_PADDING, IPHONE_VIEW_WIDTH, self.tabSelectedImageView.frame.size.height) fontName:SUB_HEADER_FONT pointSize:SUB_TITLE_FONT_SIZE];
	[self.subHeaderLabel setText:STRING_FAVORITES];
	[self.subHeaderLabel setBackgroundColor:[UIColor clearColor]];
	[self.subHeaderLabel setTextColor:[UIColor whiteColor]];
	[self.subHeaderLabel setTextAlignment:UITextAlignmentCenter];
	[self.view addSubview:self.subHeaderLabel];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navigateBack:)
										name:GO_BACK object:nil];
	
	self.airportArray = [[NSMutableArray alloc] init];
	
	self.searchHistory = [[SearchHistoryCollection alloc] init];
	
	self.previousSelectedIndex = 1;
	self.currentViewIndex = 1;
	
	[self setUpFavoritesList];
}

#pragma mark -
#pragma mark Storyboard Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	NSIndexPath *indexPath = [self.mainTableView indexPathForCell:sender];
	
	if([segue.identifier isEqualToString:@"ShowAirport"])
	{
		Airport *airport = (Airport *)[self.airportArray objectAtIndex:indexPath.row];
		[AirportDB sharedDatabase].currentAirport = airport;
	}
	else if([segue.identifier isEqualToString:@"ShowSearchHistory"])
	{
		SearchHistoryViewController *searchHistoryViewController = (SearchHistoryViewController *)segue.destinationViewController;
		searchHistoryViewController.searchHistory = self.searchHistory;
		searchHistoryViewController.delegate = self;
			
	}
}

- (void)setUpFavoritesList
{
	[self.airportArray removeAllObjects];
	
	[self.airportArray addObjectsFromArray:[AirportDB sharedDatabase].favorites];
	
	[self.mainTableView reloadData];
}

- (void)setUpAirportListWithData:(NSArray *)arr
{
	[self.airportArray removeAllObjects];
	
	MenuItem *menuItem = [MenuItem menuItemWithTitle:STRING_AIRPORTS_A_TO_Z andType:MENU_ITEM_AIRPORT_A_TO_Z];
	MenuItem *menuItem2 = [MenuItem menuItemWithTitle:STRING_NEARBY_AIRPORTS andType:MENU_ITEM_NEARBY_AIRPORTS];
	MenuItem *menuItem3 = [MenuItem menuItemWithTitle:STRING_SEARCH_HISTORY andType:MENU_ITEM_SEARCH_HISTORY];
	
	[self.airportArray addObject:menuItem];
	[self.airportArray addObject:menuItem2];
	[self.airportArray addObject:menuItem3];
	
	if(arr == nil)
		[self.airportArray addObjectsFromArray:[AirportDB sharedDatabase].airports];
	else 
		[self.airportArray addObjectsFromArray:arr];
	
	[self.mainTableView reloadData];
}

- (IBAction)tabSelected:(id)sender
{
	if(sender == nil)
	{
		UIButton *nextButton = (UIButton *)[self.view viewWithTag:self.currentViewIndex];
		[nextButton setSelected:YES];
	}
	else
	{
		UIButton *btn = (UIButton *)sender;
		[btn setSelected:YES];
		
		self.currentViewIndex = [sender tag];
	}
	
	UIButton *prevBtn = (UIButton *)[self.view viewWithTag:self.previousSelectedIndex];
	[prevBtn setSelected:NO];
	
	NSString *imageName = [NSString stringWithFormat:@"tab%iselected_header.png", self.currentViewIndex];
	self.tabSelectedImageView.image = [UIImage imageNamed:imageName];
	
	switch(self.currentViewIndex)
	{
		case FAVORITES_VIEW:
			self.subHeaderLabel.text = STRING_FAVORITES;
			[self.mainTableView setHidden:NO];
			[self.mapView setHidden:YES];
			[self setUpFavoritesList];
			break;
			
		case MAP_VIEW:
			self.subHeaderLabel.text = STRING_MAP;
			[self.mainTableView setHidden:YES];
			[self.mapView setHidden:NO];
			break;
			
		case AIRPORT_SEARCH_VIEW:
			self.subHeaderLabel.text = STRING_SEARCH;
			[self.mainTableView setHidden:NO];
			[self.mapView setHidden:YES];
			[self setUpAirportListWithData:nil];
			break;
	}
     
	//UIViewController *oldController = [self.childViewControllers objectAtIndex:self.previousSelectedIndex-1];
	//	UIViewController *newController = [self.childViewControllers objectAtIndex:self.currentViewIndex-1];
     
	//[oldController.view removeFromSuperview];
	//[self.contentView addSubview:newController.view];
	
	self.previousSelectedIndex = self.currentViewIndex;
}


- (void)viewDidUnload
{
	[self setAirportSearchBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Content Filtering
- (void)filterContentForSearchText:(NSString *)searchText
{
	NSMutableArray *unfilteredList = [NSMutableArray arrayWithArray:[AirportDB sharedDatabase].airports];
	NSMutableArray *filteredList = [NSMutableArray array];
	NSArray *predicates;
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains[cd] %@", searchText];
	NSPredicate *cityPredicate = [NSPredicate predicateWithFormat:@"city contains[cd] %@", searchText];
	NSPredicate *codePredicate = [NSPredicate predicateWithFormat:@"code contains[cd] %@", searchText];
	predicates = [NSArray arrayWithObjects:predicate, cityPredicate, codePredicate, nil];
	
	for(NSPredicate *pred in predicates)
	{
		[filteredList addObjectsFromArray:[unfilteredList filteredArrayUsingPredicate:pred]];
	}
	
	NSSet *unique = [NSSet setWithArray:filteredList];
	[self setUpAirportListWithData:[unique allObjects]];
}

#pragma mark -
#pragma mark SearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	if([searchText length] == 0)
		[self performSelector:@selector(hideKeyboardWithSearchBar:) withObject:searchBar afterDelay:0];
	else
		[self filterContentForSearchText:searchText];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
	[self.searchHistory addSearchHistoryDataWithKeywords:searchBar.text];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	[searchBar resignFirstResponder];
}

- (void)hideKeyboardWithSearchBar:(UISearchBar *)searchBar
{   
	[searchBar resignFirstResponder];
}

#pragma mark -
#pragma mark Table View Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	
	return [self.airportArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	id item = [self.airportArray objectAtIndex:indexPath.row];
	
	if([item isKindOfClass:[Airport class]])
	{
		Airport *airport = (Airport *)item;
	
		if([self.airportArray count] > 0)
			airport = (Airport *)[self.airportArray objectAtIndex:indexPath.row];
	
		if(airport.showDownload == YES)
			return AIRPORT_CELL_HEIGHT * 2 - CELL_PADDING;
     }
	
	return AIRPORT_CELL_HEIGHT;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell;
	NSString *cellIdentifier;
	
	// Set up the cell...
	id item = [self.airportArray objectAtIndex:indexPath.row];
	
	if([item isKindOfClass:[Airport class]])
	{
		AirportCell *airportCell = (AirportCell *)[tableView dequeueReusableCellWithIdentifier:@"AirportCellIdentifier"];
		
		Airport *airport = (Airport *)item;
		airportCell.delegate = self;
		
		//	[cell.downloadButton setHidden:!airport.downloadAvailable];
		
		airportCell.showDownload = airport.showDownload;
		airportCell.airportCode.text = airport.code;
		airportCell.airportName.text = airport.name;
		airportCell.airportCity.text = airport.city;
		[airportCell setNeedsDisplay];
		
		if(self.currentViewIndex == AIRPORT_SEARCH_VIEW || (airport.syncAvailable == NO && airport.downloadAvailable == NO))
		{
			[airportCell setUpCellWithOptions:AirportCellOptionsNone];
			airportCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
		else if(airport.syncAvailable == YES)
			[airportCell setUpCellWithOptions:AirportCellOptionsSync];
		else if(airport.downloadAvailable == YES)
			[airportCell setUpCellWithOptions:AirportCellOptionsDownload];
				
		return airportCell;
	}
	else if([item isKindOfClass:[MenuItem class]])
	{
		MenuItem *menuItem = (MenuItem *)item;
		if(menuItem.itemType == MENU_ITEM_NEARBY_AIRPORTS)
			cellIdentifier = @"NearbyCellIdentifier";
		else if(menuItem.itemType == MENU_ITEM_AIRPORT_A_TO_Z)
			cellIdentifier = @"ListCellIdentifier";
		else 
			cellIdentifier = @"HistoryCellIdentifier";
		
		cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
		
		cell.textLabel.text = menuItem.title;
		cell.detailTextLabel.text = @"";
		cell.imageView.image = [UIImage imageNamed:IMAGE_SEARCH_ICON];
	}
	else
		cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	id item = [self.airportArray objectAtIndex:indexPath.row];
	
	if([item isKindOfClass:[MenuItem class]])
	{
		MenuItem *menuItem = (MenuItem *)item;
		
		if(menuItem.itemType == MENU_ITEM_NEARBY_AIRPORTS)
		{
			self.currentViewIndex = MAP_VIEW;
			[self tabSelected:nil];
		}
	}
	
}

#pragma mark -
#pragma mark Map Cell Delegate
- (void)airportCellDidRequestShowDownload:(AirportCell *)cell
{
	for(Airport *airport in self.airportArray)
	{
		if([airport.code isEqualToString:cell.airportCode.text])
			airport.showDownload = !airport.showDownload;
		
		[self.mainTableView reloadData];
          
	}
}

#pragma mark -
#pragma mark Search History Delegate Methods
- (void)searchHistoryViewController:(SearchHistoryViewController *)searchHistoryVC didSelectSearchData:(SearchHistoryData *)searchData
{
	[self.navigationController popViewControllerAnimated:YES];
	
	self.airportSearchBar.text = searchData.keywords;
	
	[self filterContentForSearchText:searchData.keywords];
}

@end
