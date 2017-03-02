//
//  MovieInfoJSONManager.m
//  WeekendAssignment4
//
//  Created by TheAppExperts on 2/26/17.
//  Copyright © 2017 TheAppExperts. All rights reserved.
//

#import "MovieInfoJSONManager.h"

@implementation MovieInfoJSONManager

- (NSDictionary *)parseJSONWithData:(NSData *)jsonData
{
    NSError *error;
    NSDictionary *root = [NSJSONSerialization JSONObjectWithData:(NSData *)jsonData options:0 error:&error];
    if (!error)
    {
        return root;
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error when parsing JSON:" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okbutton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){}];
        [alert addAction: okbutton];
        [self.delegate presentAlert:alert];
        return [[NSDictionary alloc] init]; //return empty
    }
}

- (NSDictionary *)loadJSON:(NSURL *)requestURL
{
    __block NSDictionary *outputDictionary = [[NSDictionary alloc] init];
    dispatch_semaphore_t loadcomplete = dispatch_semaphore_create(0);
    NSURLRequest *request = [NSURLRequest requestWithURL: requestURL];
    NSURLSessionDataTask *download = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
          ^(NSData * data, NSURLResponse * response, NSError * error){
              if (error)
              {
                  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error when loading JSON:" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
                  UIAlertAction *okbutton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){}];
                  [alert addAction: okbutton];
                  [self.delegate presentAlert:alert];
              }
              else if (data)
              {
                  outputDictionary = [self parseJSONWithData:data];
              }
              else
              {
                  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error when loading JSON:" message:@"Missing Data" preferredStyle:UIAlertControllerStyleAlert];
                  UIAlertAction *okbutton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){}];
                  [alert addAction: okbutton];
                  [self.delegate presentAlert:alert];
              }
              dispatch_semaphore_signal(loadcomplete);
          }];
    [download resume];
    dispatch_semaphore_wait(loadcomplete, DISPATCH_TIME_FOREVER);
    return outputDictionary;
}

@end
