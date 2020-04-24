//
//  MasterViewController.h
//  Week5ObjC
//
//  Created by Field Employee on 4/23/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@class DetailViewController;

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@end

