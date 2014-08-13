#import "PBMediaRemoteNotificationObserver.h"
#import "FXKeychain.h"
#import "apikey.h"
#import "shared.h"
#import "PBMediaItem.h"
#import "LFSession.h"
#import "LFError.h"
#import "LFSignatureConstructor.h"
#import "PBScrobblerQueueNotificationObserver.h"
#import "PBScrobblerStateNotificationObserver.h"
#import "PBThumbsNotificationObserver.h"
#import <sys/stat.h>

#ifndef kMRMediaRemoteNowPlayingInfoRadioStationHash
#define kMRMediaRemoteNowPlayingInfoRadioStationHash NULL
#endif

@class PBScrobblerStateNotificationObserver;
@class PBThumbsNotificationObserver;

@interface PBScrobbler : NSObject<PBMediaRemoteNotificationObserverDelegate>{
    
    NSNotificationCenter *center;
    PBMediaRemoteNotificationObserver *mrNotificationObserver;
    PBScrobblerQueueNotificationObserver *queueObserver;
    PBScrobblerStateNotificationObserver *stateObserver;
    PBThumbsNotificationObserver *thumbsObserver;
    NSManagedObjectContext *temporaryItemsContext;
    LFSession *session;
    __strong RKManagedObjectStore *managedObjectStore;
    unsigned long submissionsCount;
}

@property BOOL shouldTerminate;
@property BOOL isPaused;
@property NSManagedObjectContext *savedItemsContext;

-(id)init;
-(void)dealloc;

-(void)configureMapping;
-(void)authenticate;
-(void)registerForNotifications;
-(void)unregisterForNotifications;

-(PBMediaItem *)mediaItemWithInfo:(NSDictionary *)info includingTimestamp:(BOOL)shouldIncludeTimestamp;
-(BOOL)shouldIgnoreTrack:(NSDictionary *)info;
-(void)sendNowPlayingWithInfo:(NSDictionary *)info;
-(void)scrobbleTrackWithInfo:(NSDictionary *)info;
-(void)scrobbleTrack:(PBMediaItem *)mediaItem;
-(void)handleQueue;

-(void)didScrobble;
-(void)couldNotScrobbleMediaItem:(PBMediaItem *)mediaItem;

-(void)setState:(scrobbleState_t)state;
-(void)setAuthResponse:(NSString *)response;
-(void)setIsRunning:(BOOL)isRunning;

// Thumbs support

-(NSDictionary *)nowPlayingArtistTitle;

-(void)nowPlayingTrackAction:(NSNotification *)notification;
-(void)trackAction:(NSNotification *)notification;

@end
