//
//  MovieInfoViewController.m
//  WeekendAssignment4
//
//  Created by TheAppExperts on 2/26/17.
//  Copyright © 2017 TheAppExperts. All rights reserved.
//

#import "MovieInfoViewController.h"
#import <CoreData/CoreData.h>

@interface MovieInfoViewController ()

@end

@implementation MovieInfoViewController

- (NSManagedObjectContext *)managedObjectContext{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]){
        context = [delegate managedObjectContext];
    }
    NSLog(@"%@", context);
    return context;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.jsonManager = [[MovieInfoJSONManager alloc] init];
    self.jsonManager.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSString *URLString = @"https://omdbapi.com/?i=";
    URLString = [URLString stringByAppendingString:self.movieID];
    URLString = [URLString stringByAppendingString:@"&r=json&plot=full"];
    NSURL *searchURL = [NSURL URLWithString:URLString];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
    ^{
        self.dataDictionary = [self.jsonManager loadJSON:searchURL];
        dispatch_async(dispatch_get_main_queue(),
        ^{
            self.titleText = [self.dataDictionary valueForKey:@"Title"];
            NSString *titleText = @"Title: ";
            titleText = [titleText stringByAppendingString: [self.dataDictionary valueForKey:@"Title"]];
            [self.titleLabel setText:titleText];
            
            NSString *releasedText = @"Released: ";
            releasedText = [releasedText stringByAppendingString: [self.dataDictionary valueForKey:@"Released"]];
            [self.releasedLabel setText:releasedText];
            
            NSString *ratedText = @"Rated: ";
            ratedText = [ratedText stringByAppendingString: [self.dataDictionary valueForKey:@"Rated"]];
            [self.ratedLabel setText:ratedText];
            
            NSString *metascoreText = @"Metascore: ";
            metascoreText = [metascoreText stringByAppendingString:[self.dataDictionary valueForKey:@"Metascore"]];
            [self.metascoreLabel setText:metascoreText];
            
            NSString *actorsText = @"Actors: ";
            actorsText = [actorsText stringByAppendingString:[self.dataDictionary valueForKey:@"Actors"]];
            [self.actorsLabel setText:actorsText];
            
            NSString *runtimeText = @"Runtime: ";
            runtimeText = [runtimeText stringByAppendingString:[self.dataDictionary valueForKey:@"Runtime"]];
            [self.runtimeLabel setText:runtimeText];
            
            
            NSString *directorText = @"Directors: ";
            directorText = [directorText stringByAppendingString:[self.dataDictionary valueForKey:@"Director"]];
            [self.directorsLabel setText:directorText];
            
            NSString *plotText = @"Plot: ";
            plotText = [plotText stringByAppendingString:[self.dataDictionary valueForKey:@"Plot"]];
            [self.plotLabel setText:plotText];
        });
        
        UIImage *dlImage = [[UIImage alloc] initWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString: [self.dataDictionary valueForKey:@"Poster"]]]];
        dispatch_async(dispatch_get_main_queue(),^{
            [self.posterImage setContentMode: UIViewContentModeScaleToFill];
            [self.posterImage setImage: dlImage];
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)presentAlert:(UIAlertController*)alert
{
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)saveAction:(id)sender {
    if ([self.titleLabel.text isEqual: @"Title Label"])
    {
        //don't save if not yet loaded
    }
    else
    {
        NSManagedObjectContext *context = [self managedObjectContext];
        NSManagedObject *newMovie = [NSEntityDescription insertNewObjectForEntityForName:@"MovieInfo" inManagedObjectContext:context];
        [newMovie setValue:self.movieID forKey:@"imdbID"];
        [newMovie setValue:self.titleText forKey:@"title"];
        NSError *error = nil;
        if (![context save:&error])
        {
            NSLog(@"Can't Save! %@", [error localizedDescription]);
        }
    }
}

@end
