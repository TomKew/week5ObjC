//
//  DetailViewController.h
//  Week5ObjC
//
//  Created by Field Employee on 4/23/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Week5ObjC+CoreDataModel.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Event *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

