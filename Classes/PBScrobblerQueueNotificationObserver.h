#import <Foundation/Foundation.h>
#import "NSDistributedNotificationCenter.h"
#import "PBMediaItem.h"

@interface PBScrobblerQueueNotificationObserver : NSObject{
    
    NSDistributedNotificationCenter *center;
    NSManagedObjectContext *context;
}

@property NSMutableDictionary *tracksToDelete;

-(void)registerForNotifications;
-(void)unregisterForNotifications;
-(void)postQueueCount;
-(void)postTracksInQueue;
-(void)deleteTrackInQueue:(NSNotification *)notification;
-(void)postDeletedTracks;
-(void)willDeleteTrack:(PBMediaItem *)mediaItem;

@end
