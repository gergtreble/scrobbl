
#import "MediaRemote.h"
#import "SpringBoardServices.h"
#import "PBMediaItem.h"
#import "PBScrobbler.h"

@protocol PBMediaRemoteNotificationObserverDelegate <NSObject>

-(void)sendNowPlayingWithInfo:(NSDictionary *)info;
-(void)scrobbleTrackWithInfo:(NSDictionary *)info;

@end

@interface PBMediaRemoteNotificationObserver : NSObject{
    NSString *lastTitle;
    NSString *lastArtist;
    NSNumber *lastUID;
    
    Boolean isPlaying;
    BOOL didScrobble;
    
    __block NSDictionary *info;
    MRMediaRemoteGetNowPlayingApplicationIsPlayingCompletion isPlayingCompletion;
}

@property id <PBMediaRemoteNotificationObserverDelegate> delegate;
@property PBScrobbler *scrobbler;
-(void)trackDidChange;

-(BOOL)canSendNowPlaying;
-(BOOL)canScrobble;

-(void)unregisterForNotifications;

@end
