//
//  JSONManager.h
//  WeekendAssignment4
//
//  Created by TheAppExperts on 2/26/17.
//  Copyright © 2017 TheAppExperts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol OMDBJSONDelegate

@required

-(void)presentAlert:(UIAlertController *)alert;

@end

@interface OMDBJSONManager : NSObject

@property (weak, nonatomic) id<OMDBJSONDelegate> delegate;

- (NSMutableArray *)loadJSON:(NSURL *)requestURL;
- (NSMutableArray *)parseJSONWithData:(NSData *)jsonData;
@end
