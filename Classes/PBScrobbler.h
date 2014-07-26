

#import "PBMediaRemoteNotificationObserver.h"
#import "FXKeychain.h"
#import "apikey.h"
#import "shared.h"
#import "PBMediaItem.h"
#import "LFSession.h"
#import "LFError.h"
#import "LFSignatureConstructor.h"
#import "PBScrobblerQueueNotificationObserver.h"
#import <sys/stat.h>

#ifndef kMRMediaRemoteNowPlayingInfoRadioStationIdentifier
#define kMRMediaRemoteNowPlayingInfoRadioStationIdentifier NULL
#endif

@interface PBScrobbler : NSObject<PBMediaRemoteNotificationObserverDelegate>{
    
    NSNotificationCenter *center;
    PBMediaRemoteNotificationObserver *observer;
    PBScrobblerQueueNotificationObserver *queueObserver;
    NSManagedObjectContext *temporaryItemsContext;
    LFSession *session;
    __strong RKManagedObjectStore *managedObjectStore;
    unsigned long submissionsCount;
}

@property BOOL shouldTerminate;
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

@end
