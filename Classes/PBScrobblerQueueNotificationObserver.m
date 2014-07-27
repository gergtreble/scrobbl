#import "PBScrobblerQueueNotificationObserver.h"

@implementation PBScrobblerQueueNotificationObserver

-(id)init{
    
    self = [super init];
    if (self) {
        center  = [NSDistributedNotificationCenter defaultCenter];
        context = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
        self.tracksToDelete = [[NSMutableDictionary alloc] init];
        [self registerForNotifications];
    }
    return self;
}

-(void)registerForNotifications{
    
    [center addObserver:self selector:@selector(postQueueCount) name:@"getQueueCount" object:@"com.pb.scrobbled"];
    [center addObserver:self selector:@selector(deleteTrackInQueue:) name:@"deleteTrackInQueue" object:@"com.pb.scrobbled"];
    [center addObserver:self selector:@selector(postTracksInQueue) name:@"getTracksInQueue" object:@"com.pb.scrobbled"];
}

-(void)postQueueCount{
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MediaItem" inManagedObjectContext:context];
    [request setEntity:entity];
    
    NSError *error;
    NSArray *mediaItems = [context executeFetchRequest:request error:&error];
    NSNumber *count = [NSNumber numberWithLong:[mediaItems count]];
    [[NSUserDefaults standardUserDefaults] setObject:[count stringValue] forKey:@"queueCount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [center postNotificationName:@"queueCountDidChange" object:@"com.pb.scrobbled" userInfo:nil deliverImmediately:YES];
    
}

-(void)postTracksInQueue{
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MediaItem" inManagedObjectContext:context];
    [request setEntity:entity];
    
    NSError *error;
    NSArray *mediaItems = [context executeFetchRequest:request error:&error];
    NSMutableDictionary *tracks = [[NSMutableDictionary alloc] init];
    
    for (PBMediaItem *mediaItem in mediaItems) {
        [tracks setObject:[NSString stringWithFormat:@"%@ – %@", mediaItem.artist, mediaItem.title] forKey:[mediaItem.timestamp stringValue]];
    }
    
    
    [center postNotificationName:@"queueTracks" object:@"com.pb.scrobbled" userInfo:tracks deliverImmediately:YES];
}

-(void)deleteTrackInQueue:(NSNotification *)notification{
    
    NSNumber *timestamp = [[[notification userInfo] allKeys] firstObject];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"timestamp = %@", timestamp];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MediaItem" inManagedObjectContext:context];
    [request setEntity:entity];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *mediaItems = [context executeFetchRequest:request error:&error];
    
    if (mediaItems) {
        [context deleteObject:[mediaItems firstObject]];
        [self postDeletedTracks];
        [context saveToPersistentStore:&error];
    }
    
}

-(void)willDeleteTrack:(PBMediaItem *)mediaItem{
    
    [self.tracksToDelete setObject:[NSString stringWithFormat:@"%@ – %@", mediaItem.artist, mediaItem.title] forKey:[mediaItem.timestamp stringValue]];
}

-(void)postDeletedTracks{
    
    [center postNotificationName:@"deletedTracks" object:@"com.pb.scrobbled" userInfo:self.tracksToDelete deliverImmediately:YES];
}

-(void)unregisterForNotifications{
    
    [center removeObserver:self];
}

-(void)dealloc{
    
    [self unregisterForNotifications];
}

@end
