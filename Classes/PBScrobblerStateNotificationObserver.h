#import <Foundation/Foundation.h>
#import "PBScrobbler.h"
@class PBScrobbler;
@interface PBScrobblerStateNotificationObserver : NSObject{
    
    NSNotificationCenter *center;
    BOOL previousState;
}

@property PBScrobbler *scrobbler;
-(void)registerForNotifications;
-(void)unregisterForNotifications;

-(void)pauseScrobbler;
-(void)continueScrobbler;

-(void)defaultsDidChange;

@end
