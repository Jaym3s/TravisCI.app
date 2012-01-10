//
//  BWBuildListViewController.h
//  TravisCI
//
//  Created by Bradley Grzesiak on 1/9/12.
//  Copyright (c) 2012 Bendyworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BWRepository, BWJobListViewController;

@interface BWBuildListViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) UINib *buildCellNib;

@property (nonatomic, strong) NSFetchedResultsController *fetchedResults;
@property (nonatomic, strong) BWRepository *repository;
@property (nonatomic, strong) BWJobListViewController *jobListController;

@end
