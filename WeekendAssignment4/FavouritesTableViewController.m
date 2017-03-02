//
//  FavouritesTableViewController.m
//  WeekendAssignment4
//
//  Created by TheAppExperts on 2/27/17.
//  Copyright © 2017 TheAppExperts. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "FavouritesTableViewController.h"
#import "MovieInfoViewController.h"
//#import "MovieInfo+CoreDataProperties.h"

@interface FavouritesTableViewController ()

@end

@implementation FavouritesTableViewController

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"MovieInfo"];
    self.favouriteMovies = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.favouriteMovies count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Favourite"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] init];
    }
    NSManagedObject *readMovie = [self.favouriteMovies objectAtIndex:indexPath.row];
    [cell.textLabel setText:[readMovie valueForKey:@"title"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSLog(@"%@",[self.favouriteMovies objectAtIndex:indexPath.row]);
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSManagedObject *data = [[self.favouriteMovies objectAtIndex:indexPath.row] initWithContext:managedObjectContext];
    NSString *imdbID = [data valueForKey:@"imdbID"];
    MovieInfoViewController *mivController = [self.storyboard instantiateViewControllerWithIdentifier:@"movieInfo"];
    mivController.movieID = imdbID;
    [self.navigationController pushViewController:mivController animated:YES];
    
}

@end
