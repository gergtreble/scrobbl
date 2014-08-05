#import "PBScrobbler.h"
#import "NSDistributedNotificationCenter.h"

@class PBScrobbler;

@interface PBThumbsNotificationObserver : NSObject{
    
    NSDistributedNotificationCenter *center;
    PBScrobbler *scrobbler;
}

-(id)initWithScrobbler:(PBScrobbler *)scrobbler;

-(void)registerForNotifications;
-(void)unregisterForNotifications;

-(void)postResult:(BOOL)result forAction:(NSString *)action;

@end
