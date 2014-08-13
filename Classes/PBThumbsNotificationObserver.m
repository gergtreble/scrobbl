#import "PBThumbsNotificationObserver.h"

@implementation PBThumbsNotificationObserver

-(id)initWithScrobbler:(PBScrobbler *)_scrobbler{
    
    self = [super init];
    if (self) {
        center  = [NSDistributedNotificationCenter defaultCenter];
        scrobbler = _scrobbler;
        [self registerForNotifications];
    }
    
    return self;
}

-(void)dealloc{
    
    [self unregisterForNotifications];
}

-(void)registerForNotifications{
    
    NSString *obj = @"com.rthakrar.thumbs";
    
    [center addObserver:scrobbler selector:@selector(nowPlayingTrackAction:) name:@"loveNowPlayingTrack" object:obj];
    [center addObserver:scrobbler selector:@selector(nowPlayingTrackAction:) name:@"unloveNowPlayingTrack" object:obj];
    
    [center addObserver:scrobbler selector:@selector(nowPlayingTrackAction:) name:@"banNowPlayingTrack" object:obj];
    [center addObserver:scrobbler selector:@selector(nowPlayingTrackAction:) name:@"unbanNowPlayingTrack" object:obj];
    
    [center addObserver:scrobbler selector:@selector(trackAction:) name:@"loveTrack" object:obj];
    [center addObserver:scrobbler selector:@selector(trackAction:) name:@"unloveTrack" object:obj];
    
    [center addObserver:scrobbler selector:@selector(trackAction:) name:@"banTrack" object:obj];
    [center addObserver:scrobbler selector:@selector(trackAction:) name:@"unbanTrack" object:obj];
    
}

-(void)unregisterForNotifications{
    
    [center removeObserver:self];
}

-(void)postResult:(BOOL)result forAction:(NSString *)action withInfo:(NSDictionary *)info{
    
    [center postNotificationName:@"thumbsResult" object:@"com.pb.scrobbled" userInfo:@{action:[NSNumber numberWithBool:result], [[info allKeys] firstObject]: [[info allValues] firstObject]} deliverImmediately:YES];
}

@end
