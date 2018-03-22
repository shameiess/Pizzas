#import <Foundation/Foundation.h>

@interface API : NSObject
+(void)fetchMenuWithCompletion:(void(^)(NSArray *))block;
@end
