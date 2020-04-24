//
//  DetailViewController.h
//  Week5ObjC
//
//  Created by Field Employee on 4/23/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "storage.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) storage *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *schoolNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numOfTakersLabel;
@property (weak, nonatomic) IBOutlet UILabel *readingScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *mathScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *writingScoreLabel;

@end


