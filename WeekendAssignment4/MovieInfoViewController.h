//
//  MovieInfoViewController.h
//  WeekendAssignment4
//
//  Created by TheAppExperts on 2/26/17.
//  Copyright © 2017 TheAppExperts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieInfoJSONManager.h"

@interface MovieInfoViewController : UIViewController <MovieJSONDelegate>

@property (strong, nonatomic) NSString *movieID;
@property (strong, nonatomic) NSString *titleText;
@property (strong, nonatomic) MovieInfoJSONManager *jsonManager;
@property (strong, nonatomic) NSDictionary *dataDictionary;

@property (strong, nonatomic) IBOutlet UIImageView *posterImage;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *releasedLabel;
@property (strong, nonatomic) IBOutlet UILabel *ratedLabel;
@property (strong, nonatomic) IBOutlet UILabel *metascoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *actorsLabel;
@property (strong, nonatomic) IBOutlet UILabel *runtimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *directorsLabel;
@property (strong, nonatomic) IBOutlet UILabel *plotLabel;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;

- (IBAction)saveAction:(id)sender;

@end
