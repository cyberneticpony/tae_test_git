//
//  OMDBSearchViewController.m
//  WeekendAssignment4
//
//  Created by TheAppExperts on 2/26/17.
//  Copyright © 2017 TheAppExperts. All rights reserved.
//

#import "OMDBSearchViewController.h"
#import "MovieCollectionViewCell.h"
#import "MovieInfoViewController.h"

@interface OMDBSearchViewController ()

@end

@implementation OMDBSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.searchBar setDelegate:self];
    self.jsonManager = [[OMDBJSONManager alloc] init];
    [self.jsonManager setDelegate:self];
    UINib *nib = [UINib nibWithNibName:@"MovieCollectionViewCell" bundle:[NSBundle mainBundle]];
    [self.searchResults setDelegate:self];
    [self.searchResults setDataSource:self];
    [self.searchResults registerNib:nib forCellWithReuseIdentifier:@"MovieCollectionViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)presentAlert:(UIAlertController*)alert
{
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    NSString *URLString = @"https://omdbapi.com/?s=";
    NSString *URLSearch = [searchBar.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    URLString = [URLString stringByAppendingString:URLSearch];
    URLString = [URLString stringByAppendingString:@"&r=json&page=1"];
    NSURL *searchURL = [NSURL URLWithString:URLString];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{self.arrayOfResults = [self.jsonManager loadJSON:searchURL];
        dispatch_async(dispatch_get_main_queue(),^{
            [self.searchResults reloadData];});
    });
}

//Collection View Methods Beyond This Point

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCollectionViewCell" forIndexPath:indexPath];
    
    [cell.movieTextField setText: [(NSDictionary *)[self.arrayOfResults objectAtIndex:indexPath.row] valueForKey:@"Title"]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
    ^{
        NSString *urlStringOfPoster = [(NSDictionary *)[self.arrayOfResults objectAtIndex:indexPath.row] valueForKey:@"Poster"];
        UIImage *dlImage = [[UIImage alloc] initWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:urlStringOfPoster]]];
        dispatch_async(dispatch_get_main_queue(),^{
            [cell.posterImage setContentMode: UIViewContentModeScaleAspectFill];
            [cell.posterImage setImage: dlImage];
        });
    });
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0){
        return [self.arrayOfResults count];
    }
    else
    {
        return 0; //there should be no other sections
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieInfoViewController *mivController = [self.storyboard instantiateViewControllerWithIdentifier:@"movieInfo"];
    mivController.movieID = [(NSDictionary *)[self.arrayOfResults objectAtIndex:indexPath.row] valueForKey:@"imdbID"];
    [self.navigationController pushViewController:mivController animated:YES];
}

@end
