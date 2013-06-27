//
//  AirportListViewController.m
//  Terminal Map 3
//
//  Created by Jennifer Duffey on 1/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AirportListViewController.h"
#import "AirportDB.h"
#import "Airport.h"

@implementation AirportListViewController
@synthesize airportTableView = _airportTableView;
@synthesize airportList = _airportList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)goBack:(id)sender 
{
	[self.navigationController popViewControllerAnimated:YES];
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

#pragma mark -
#pragma mark Storyboard Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	NSIndexPath *indexPath = [self.airportTableView indexPathForCell:sender];
	
	if([segue.identifier isEqualToString:@"ShowAirport"])
	{
		Airport *airport = (Airport *)[self.airportList objectAtIndex:indexPath.row];
		[AirportDB sharedDatabase].currentAirport = airport;
	}
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.airportList = [[NSMutableArray alloc] init];
	
	[self sortAirports];
}


- (void)sortAirports
{
	UILocalizedIndexedCollation *coll = [UILocalizedIndexedCollation currentCollation];
	
	NSArray *airports = [AirportDB sharedDatabase].airports;
	
	for(Airport *airport in airports)
	{
		NSInteger sect = [coll sectionForObject:airport collationStringSelector:@selector(code)];
		airport.sectionNumber = sect;
	}
	
	NSInteger highSection = [[coll sectionTitles] count];
	NSMutableArray *sectionArrays = [NSMutableArray arrayWithCapacity:highSection];
	for(int i = 0; i <= highSection; i++)
	{
		NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
		[sectionArrays addObject:sectionArray];
	}
	
	for(Airport *airport in airports)
	{
		[(NSMutableArray *)[sectionArrays objectAtIndex:airport.sectionNumber] addObject:airport];
	}
	
	for(NSMutableArray *sectionArray in sectionArrays)
	{
		NSArray *sortedSection = [coll sortedArrayFromArray:sectionArray collationStringSelector:@selector(code)];
		[self.airportList addObject:sortedSection];
	}
	
	[self.airportTableView reloadSectionIndexTitles];
}

- (void)viewDidUnload
{
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
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
     // Return the number of sections.
     return [self.airportList count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section 
{
	if([[self.airportList objectAtIndex:section] count] > 0)
		return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
	
	return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
     return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
	return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
     // Return the number of rows in the section.
	return [[self.airportList objectAtIndex:section] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
     static NSString *CellIdentifier = @"AirportCellIdentifier";
	
	AirportCell *airportCell = (AirportCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	Airport *airport = (Airport *)[[self.airportList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	
	// Set up the cell...
	airportCell.delegate = self;
	
	[airportCell.downloadButton setHidden:!airport.downloadAvailable];
	
	if(airport.downloadAvailable == NO)
		airportCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	airportCell.showDownload = airport.showDownload;
	airportCell.airportCode.text = airport.code;
	airportCell.airportName.text = airport.name;
	airportCell.airportCity.text = airport.city;
	
	return airportCell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
}

@end
