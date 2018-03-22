#import "API.h"

@implementation API
+(void)fetchMenuWithCompletion:(void(^)(NSArray *))block
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.myjson.com/bins/d7wgd"]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSArray *resArr = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:nil];
                        block(resArr);
                    });
                }] resume];
}
@end
