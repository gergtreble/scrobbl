#import <Foundation/Foundation.h>
#import "PBScrobbler.h"
@class PBScrobbler;
@interface PBScrobblerStateNotificationObserver : NSObject{
    
    NSNotificationCenter *center;
    BOOL previousState;
    PBScrobbler *scrobbler;
}

-(id)initWithScrobbler:(PBScrobbler *)_scrobbler;
-(void)registerForNotifications;
-(void)unregisterForNotifications;

-(void)pauseScrobbler;
-(void)continueScrobbler;

-(void)defaultsDidChange;

@end
