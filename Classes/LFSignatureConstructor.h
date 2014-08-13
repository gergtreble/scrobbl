
#import <Foundation/Foundation.h>
#import "NSString+MD5.h"
#import "PBMediaItem.h"
#import "LFSession.h"
#import "apikey.h"

@interface LFSignatureConstructor : NSObject


+ (NSString *)generateSignatureFromDictionary:(NSDictionary *)dict withSecret:(NSString *)secret;

// Scrobbling/updating nowplaying

+ (NSDictionary *)generateParametersWithMediaItem:(PBMediaItem *)mediaItem withSession:(LFSession *)session withMethod:(NSString *)method;
+ (NSDictionary *)generateParametersWithMediaItems:(NSArray *)mediaItems withSession:(LFSession *)session withMethod:(NSString *)method;

// Loving/banning

+ (NSDictionary *)generateRequestWithInfo:(NSDictionary *)info withSession:(LFSession *)session withAction:(NSString *)action;

@end
