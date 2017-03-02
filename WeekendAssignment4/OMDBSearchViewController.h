//
//  OMDBSearchViewController.h
//  WeekendAssignment4
//
//  Created by TheAppExperts on 2/26/17.
//  Copyright © 2017 TheAppExperts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMDBJSONManager.h"

@interface OMDBSearchViewController : UIViewController <UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, OMDBJSONDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UICollectionView *searchResults;
@property (strong, nonatomic) OMDBJSONManager *jsonManager;
@property (strong, nonatomic) NSMutableArray *arrayOfResults;

@end
