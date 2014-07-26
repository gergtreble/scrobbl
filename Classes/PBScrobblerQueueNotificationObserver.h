#import <Foundation/Foundation.h>
#import "NSDistributedNotificationCenter.h"
#import "PBMediaItem.h"

@interface PBScrobblerQueueNotificationObserver : NSObject{
    
    NSDistributedNotificationCenter *center;
    NSManagedObjectContext *context;
}

-(void)registerForNotifications;
-(void)unregisterForNotifications;
-(void)postQueueCount;
-(void)postTracksInQueue;
-(void)deleteTrackInQueue:(NSNotification *)notification;
-(void)postDeletedTracks;

@end
