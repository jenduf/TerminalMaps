//
//  OverviewViewController.m
//  Terminal Map 3
//
//  Created by Jennifer Duffey on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewStackController.h"
#import "Utils.h"
#import "Constants.h"
#import "InteractiveMapViewController.h"
#import "OverviewViewController.h"

@implementation ViewStackController
@synthesize menuTableView = _menuTableView;
@synthesize menuItems = _menuItems;
@synthesize menuTitles = _menuTitles;
@synthesize contentView = _contentView;
@synthesize contentNavController = _contentNavController;

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
	
	OverviewViewController *ovc = (OverviewViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"OverviewView"];
	
	self.contentNavController = [[UINavigationController alloc] initWithRootViewController:ovc];
	self.contentNavController.view.frame = self.contentView.bounds;
	[self.contentNavController setNavigationBarHidden:YES];
	
	[self.contentView addSubview:self.contentNavController.view];
	
	self.menuItems = [[NSDictionary alloc] initWithDictionary:[Utils getMenuItemsForView:OVERVIEW_VIEW]];
	
	self.menuTitles = [[NSArray alloc] initWithArray:[self.menuItems allKeys]];
	
	[self.menuTableView reloadData];
}


- (void)viewDidUnload
{
	[self setMenuTableView:nil];
	[self setContentView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)revealMenu:(id)sender 
{
	if(self.view.frame.origin.x < 0)
		[Utils animateView:self.view from:self to:CGPointMake(0, 0)];
	else
		[Utils animateView:self.view from:self to:CGPointMake(-240, 0)];
}

- (IBAction)goBack:(id)sender 
{
	if([self.contentNavController.viewControllers count] == 1)
		[self.navigationController popViewControllerAnimated:YES];
	else
		[self.contentNavController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Table View Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	return [self.menuTitles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	NSString *key = [self.menuTitles objectAtIndex:section];
	NSArray *items = [self.menuItems objectForKey:key];
	
	return [items count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	NSString *key = [self.menuTitles objectAtIndex:section];

	UILabel *sectionHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, IPHONE_VIEW_WIDTH, SECTION_HEADER_HEIGHT)];
	sectionHeaderLabel.backgroundColor = [UIColor darkGrayColor];
	sectionHeaderLabel.textColor = [UIColor lightGrayColor];
	sectionHeaderLabel.font = [UIFont boldSystemFontOfSize:SUB_HEADER_FONT_SIZE];
	sectionHeaderLabel.text = key;
	
	return sectionHeaderLabel;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
     static NSString *CellIdentifier = @"MenuCellIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	// Set up the cell...
	NSString *key = [self.menuTitles objectAtIndex:indexPath.section];
	NSArray *items = [self.menuItems objectForKey:key];
	
	NSString *item = [items objectAtIndex:indexPath.row];
	cell.textLabel.text = item;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	NSString *key = [self.menuTitles objectAtIndex:indexPath.section];
	NSArray *items = [self.menuItems objectForKey:key];
	
	NSString *item = [items objectAtIndex:indexPath.row];
	
	if([item isEqualToString:@"Airport Info"])
	{
		
	}
	
}

@end
