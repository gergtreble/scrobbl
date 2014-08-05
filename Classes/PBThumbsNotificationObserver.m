#import "PBThumbsNotificationObserver.h"

@implementation PBThumbsNotificationObserver

-(id)init{
    
    self = [super init];
    if (self) {
        center  = [NSDistributedNotificationCenter defaultCenter];
        [self registerForNotifications];
    }
    
    return self;
}

-(void)dealloc{
    
    [self unregisterForNotifications];
}

-(void)registerForNotifications{
    
    NSString *obj = @"com.rthakrar.thumbs";
    
    [center addObserver:self.scrobbler selector:@selector(loveNowPlayingTrack) name:@"loveNowPlayingTrack" object:obj];
    [center addObserver:self.scrobbler selector:@selector(unloveNowPlayingTrack) name:@"unloveNowPlayingTrack" object:obj];
    
    [center addObserver:self.scrobbler selector:@selector(banNowPlayingTrack) name:@"banNowPlayingTrack" object:obj];
    [center addObserver:self.scrobbler selector:@selector(unbanNowPlayingTrack) name:@"unbanNowPlayingTrack" object:obj];
}

-(void)unregisterForNotifications{
    
    [center removeObserver:self];
}

-(void)postResult:(BOOL)result forAction:(NSString *)action{
    
    [center postNotificationName:@"thumbsResult" object:@"com.pb.scrobbled" userInfo:@{action:[NSNumber numberWithBool:result]} deliverImmediately:YES];
}

@end
