//
//  BWJobTableView.m
//  TravisCI
//
//  Created by Bradley Grzesiak on 1/6/12.
//  Copyright (c) 2012 Bendyworks. All rights reserved.
//

#import "BWJobListViewController.h"
#import "RestKit/CoreData.h"
#import "BWJob.h"
#import "BWJobTableCell.h"

@interface BWJobListViewController()

- (void)configureCell:(BWJobTableCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end


@implementation BWJobListViewController


@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize jobCellNib;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated { [super viewWillAppear:animated]; }

- (void)viewDidAppear:(BOOL)animated { [super viewDidAppear:animated]; }

- (void)viewWillDisappear:(BOOL)animated { [super viewWillDisappear:animated]; }

- (void)viewDidDisappear:(BOOL)animated { [super viewDidDisappear:animated]; }

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return [[self.fetchedResultsController sections] count]; }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    NSLog(@"cell for row at index path");
    BWJobTableCell *cell = [BWJobTableCell cellForTableView:tableView fromNib:self.jobCellNib];
    [self configureCell:cell atIndexPath:indexPath];

    return cell;
}

- (void)configureCell:(BWJobTableCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    BWJob *job = [BWJob presenterWithObject:[[self fetchedResultsController] objectAtIndexPath:indexPath]];
    
    
    NSString *statusImage = @"status_yellow";
    UIColor *textColor = [UIColor blackColor];
    if (job.status != nil) {
        if (job.status == [NSNumber numberWithInt:0]) {
            statusImage = @"status_green";
            textColor = [UIColor colorWithRed:0.0f green:0.5f blue:0.0f alpha:1.0f];
        } else {
            statusImage = @"status_red";
            textColor = [UIColor colorWithRed:0.75f green:0.0f blue:0.0f alpha:1.0f];
        }
    }
    
    [cell.buildIcon setImage:[UIImage imageNamed:statusImage]];
    [cell.number setText:job.number];
    [cell.number setTextColor:textColor];
    //    [cell.duration setText:job.duration_text];
    //    [cell.finished setText:job.duration_text];

}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (UINib *)jobCellNib
{
    if (jobCellNib == nil) {
        self.jobCellNib = [BWJobTableCell nib];
    }
    return jobCellNib;
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (__fetchedResultsController != nil) {
        return __fetchedResultsController;
    }
    
    NSManagedObjectContext *moc = [[RKObjectManager sharedManager].objectStore managedObjectContext];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BWCDJob" inManagedObjectContext:moc];
    [fetchRequest setEntity:entity];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"number" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                                managedObjectContext:moc
                                                                                                  sectionNameKeyPath:nil
                                                                                                           cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;

	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	    /*
	     Replace this implementation with code to handle the error appropriately.
         
	     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	     */
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return __fetchedResultsController;
}    

@end
