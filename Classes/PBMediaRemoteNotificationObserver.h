
#import "MediaRemote.h"
#import "SpringBoardServices.h"
#import "PBMediaItem.h"

@protocol PBMediaRemoteNotificationObserverDelegate <NSObject>

-(void)sendNowPlayingWithInfo:(NSDictionary *)info;
-(void)scrobbleTrackWithInfo:(NSDictionary *)info;

@end

@class PBScrobbler;

@interface PBMediaRemoteNotificationObserver : NSObject{
    NSString *lastTitle;
    NSString *lastArtist;
    NSNumber *lastUID;
    
    Boolean isPlaying;
    BOOL didScrobble;
    
    __block NSDictionary *info;
    MRMediaRemoteGetNowPlayingApplicationIsPlayingCompletion isPlayingCompletion;
    PBScrobbler *scrobbler;
}

@property id <PBMediaRemoteNotificationObserverDelegate> delegate;

-(id)initWithScrobbler:(PBScrobbler *)_scrobbler;
-(void)trackDidChange;

-(BOOL)canSendNowPlaying;
-(BOOL)canScrobble;

-(void)unregisterForNotifications;
-(NSString *)nowPlayingApplicationIdentifier;

-(NSDictionary *)nowPlayingArtistTitle;

@end
