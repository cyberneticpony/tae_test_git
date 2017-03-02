//
//  MovieInfoJSONManager.h
//  WeekendAssignment4
//
//  Created by TheAppExperts on 2/26/17.
//  Copyright © 2017 TheAppExperts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol MovieJSONDelegate

@required

-(void)presentAlert:(UIAlertController *)alert;

@end

@interface MovieInfoJSONManager : NSObject

@property (weak, nonatomic) id<MovieJSONDelegate> delegate;

- (NSDictionary *)loadJSON:(NSURL *)requestURL;
- (NSDictionary *)parseJSONWithData:(NSData *)jsonData;

@end
