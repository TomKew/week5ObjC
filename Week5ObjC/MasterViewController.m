//
//  MasterViewController.m
//  Week5ObjC
//
//  Created by Field Employee on 4/23/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "storage.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@property NSMutableArray *schools;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchSchools];
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}


- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)fetchSchools {
    NSString *urlString = @"https://data.cityofnewyork.us/resource/f9bf-2cp4.json";
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        NSArray *schoolsJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSLog(@"Failed to serialize JSON");
            return;
        }
        
        NSMutableArray<storage *> *schools = NSMutableArray.new;
        for (NSDictionary *schoolDict in schoolsJSON) {
            NSString *name = schoolDict[@"school_name"];
            NSString *numOfTested = schoolDict[@"num_of_sat_test_takers"];
            NSString *readingScore = schoolDict[@"sat_critical_reading_avg_score"];
            NSString *mathScore = schoolDict[@"sat_math_avg_score"];
            NSString *writingScore = schoolDict[@"sat_writing_avg_score"];
            storage *school = storage.new;
            school.schoolName = name;
            school.numOfTested = numOfTested;
            school.readingScore = readingScore;
            school.mathScore = mathScore;
            school.writingScore = writingScore;
            [schools addObject:school];
        }
        
        self.schools = schools;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }] resume];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        storage *school = self.schools[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        controller.detailItem = school;
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
        self.detailViewController = controller;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.schools.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    storage *school = self.schools[indexPath.row];
    cell.textLabel.text = [school schoolName];
    return cell;
}

@end
