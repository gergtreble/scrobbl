#import "PBScrobbler.h"
#import "NSDistributedNotificationCenter.h"

@class PBScrobbler;

@interface PBThumbsNotificationObserver : NSObject{
    
    NSDistributedNotificationCenter *center;
}

@property PBScrobbler *scrobbler;

-(void)registerForNotifications;
-(void)unregisterForNotifications;

-(void)postResult:(BOOL)result forAction:(NSString *)action;

@end
