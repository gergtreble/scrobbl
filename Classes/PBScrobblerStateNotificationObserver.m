#import "PBScrobblerStateNotificationObserver.h"

PBScrobblerStateNotificationObserver *observerRef;

void stateDidChange(){
    
    [observerRef stateDidChange];
}

@implementation PBScrobblerStateNotificationObserver

-(id)initWithScrobbler:(PBScrobbler *)_scrobbler{
    
    self = [super init];
    if (self) {
        center = CFNotificationCenterGetDarwinNotifyCenter();
        scrobbler = _scrobbler;
        observerRef = self;
        [self registerForNotifications];
    }
    return self;
}

-(void)dealloc{
    
    [self unregisterForNotifications];
}

-(void)registerForNotifications{
    
    CFNotificationCenterAddObserver(center, NULL, stateDidChange, CFSTR("com.pb.scrobbled.stateDidChange"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}

-(void)unregisterForNotifications{
    
    CFNotificationCenterRemoveEveryObserver(center, (__bridge void *)self);
}

-(void)stateDidChange{
    
    if (scrobbler.isPaused) {
        [self continueScrobbler];
    }
    
    else{
        [self pauseScrobbler];
    }

}

-(void)pauseScrobbler{
    
    NSLog(@"Pausing scrobbler");
    scrobbler.isPaused = YES;
}

-(void)continueScrobbler{
    
    NSLog(@"Continuing scrobbler");
    scrobbler.isPaused = NO;
}

@end
