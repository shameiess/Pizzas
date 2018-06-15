//
//  UIImageView+Persist.m
//  Interview
//
//  Created by Kevin Nguyen on 6/9/18.
//  Copyright © 2018 Zume Pizza, Inc. All rights reserved.
//

#import "UIImageView+Persist.h"
#import "API.h"

@implementation UIImageView (Persist)

- (void)kd_setImageWithURL:(NSString *)url {
    if ([[[API shared] imageCache] valueForKey:url] != nil) {
        self.image = [[[API shared] imageCache] valueForKey:url];
    }
    else {
        [[NSURLSession.sharedSession dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error || !data) {
                dispatch_async(dispatch_get_main_queue(), ^{
                	self.image = nil;
                });
            }
            
            UIImage *image = [UIImage imageWithData:data];
            [[[API shared] imageCache] setValue:image forKey:url];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = image;
            });
        }] resume];
    }
}
@end
