#import <Foundation/Foundation.h>

@interface LFError : NSObject

@property NSString *message;
@property NSUInteger error;

-(NSString *)description;

@end
