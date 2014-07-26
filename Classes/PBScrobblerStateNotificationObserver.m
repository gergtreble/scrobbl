#import "PBScrobblerStateNotificationObserver.h"

@implementation PBScrobblerStateNotificationObserver

-(id)init{
    
    self = [super init];
    if (self) {
        center = [NSNotificationCenter defaultCenter];
        previousState = [[[NSUserDefaults standardUserDefaults] objectForKey:@"scrobblerEnabled"] boolValue];
        [self registerForNotifications];
    }
    return self;
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
    
    self.scrobbler.isPaused = YES;
}

-(void)continueScrobbler{
    
    self.scrobbler.isPaused = NO;
}

@end
