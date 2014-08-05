
#import <Foundation/Foundation.h>
#import "NSString+MD5.h"
#import "PBMediaItem.h"
#import "LFSession.h"
#import "apikey.h"

@interface LFSignatureConstructor : NSObject

+ (NSString *)generateSignatureFromDictionary:(NSDictionary *)dict withSecret:(NSString *)secret;
+ (NSDictionary *)generateParametersWithMediaItem:(PBMediaItem *)mediaItem withSession:(LFSession *)session withMethod:(NSString *)method;
+ (NSDictionary *)generateParametersWithMediaItems:(NSArray *)mediaItems withSession:(LFSession *)session withMethod:(NSString *)method;
+ (NSDictionary *)generateParametersWithInfo:(NSDictionary *)info withSession:(LFSession *)session withMethod:(NSString *)method;

@end
