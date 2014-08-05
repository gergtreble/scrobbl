#import "PBScrobblerStateNotificationObserver.h"

@implementation PBScrobblerStateNotificationObserver

-(id)initWithScrobbler:(PBScrobbler *)_scrobbler{
    
    self = [super init];
    if (self) {
        center = [NSNotificationCenter defaultCenter];
        previousState = [[[NSUserDefaults standardUserDefaults] objectForKey:@"scrobblerEnabled"] boolValue];
        scrobbler = _scrobbler;
        [self registerForNotifications];
    }
    return self;
}

-(void)dealloc{
    
    [self unregisterForNotifications];
}

-(void)registerForNotifications{
    
    [center addObserver:self selector:@selector(defaultsDidChange) name:NSUserDefaultsDidChangeNotification object:nil];
}

-(void)unregisterForNotifications{
    
    [center removeObserver:self];
}

-(void)defaultsDidChange{
    
    BOOL currentState =  [[[NSUserDefaults standardUserDefaults] objectForKey:@"scrobblerEnabled"] boolValue];
    
    if (!(currentState & previousState)) {
        if (!currentState) {
            [self pauseScrobbler];
        }
        else{
            [self continueScrobbler];
        }
    }
}

-(void)pauseScrobbler{
    
    scrobbler.isPaused = YES;
}

-(void)continueScrobbler{
    
    scrobbler.isPaused = NO;
}

@end
