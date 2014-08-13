
#import "LFSignatureConstructor.h"

@implementation LFSignatureConstructor

static NSInteger sortAlpha(NSString *n1, NSString *n2, void *context){
    
    return [n1 caseInsensitiveCompare:n2];
}

+ (NSString *)generateSignatureFromDictionary:(NSDictionary *)dict withSecret:(NSString *)secret {
    
	NSMutableArray *ar= [[NSMutableArray alloc] initWithArray:[dict allKeys]];
	NSMutableString *rawSig = [[NSMutableString alloc] init];
	[ar sortUsingFunction:sortAlpha context:(__bridge void *)(self)];
    
	for(NSString *key in ar) {
		[rawSig appendString:[NSString stringWithFormat:@"%@%@", key, [dict objectForKey:key]]];
	}
    
	[rawSig appendString:secret];
    
	return [rawSig md5sum];
}

+ (NSDictionary *)generateParametersWithMediaItem:(PBMediaItem *)mediaItem withSession:(LFSession *)session withMethod:(NSString *)method{
    
//    Used for single track scrobbling
    
    if (!mediaItem.title || !mediaItem.artist) {
        
        return nil;
    }
    
    NSMutableDictionary *ret = [@{@"sk": session.key,
                                  @"api_key": kLFAPIKey,
                                  @"method": method} mutableCopy];
    
    [ret setObject:mediaItem.title forKey:@"track"];
    [ret setObject:mediaItem.artist forKey:@"artist"];
    
    if ([mediaItem.timestamp integerValue]){
        [ret setObject:[NSString stringWithFormat:@"%@", mediaItem.timestamp] forKey:@"timestamp"];
    }
    
    if (mediaItem.album) {
        [ret setObject:mediaItem.album forKey:@"album"];
    }
    
    if (mediaItem.duration) {
        [ret setObject:[NSString stringWithFormat:@"%@", mediaItem.duration] forKey:@"duration"];
    }
    
    NSString *sig = [self generateSignatureFromDictionary:ret withSecret:kLFAPISecret];
    
    [ret setObject:sig forKey:@"api_sig"];
    
    return ret;
}

+ (NSDictionary *)generateParametersWithMediaItems:(NSArray *)mediaItems withSession:(LFSession *)session withMethod:(NSString *)method{
    
//    Used for batch scrobbling
    
    NSMutableDictionary *ret = [@{@"sk": session.key,
                                  @"api_key": kLFAPIKey,
                                  @"method": method} mutableCopy];
    
    unsigned int i = 0;
    for (PBMediaItem *mediaItem in mediaItems) {
        
        [ret setObject:mediaItem.title forKey:[NSString stringWithFormat:@"track[%@]", @(i)]];
        [ret setObject:mediaItem.artist forKey:[NSString stringWithFormat:@"artist[%@]", @(i)]];
        
        [ret setObject:[NSString stringWithFormat:@"%@", mediaItem.timestamp] forKey:[NSString stringWithFormat:@"timestamp[%@]", @(i)]];
        
        if (mediaItem.album) {
            [ret setObject:mediaItem.album forKey:[NSString stringWithFormat:@"album[%@]", @(i)]];
        }
        
        if (mediaItem.duration) {
            [ret setObject:[NSString stringWithFormat:@"%@", mediaItem.duration] forKey:[NSString stringWithFormat:@"duration[%d]",i]];
        }
       
        i++;
    }
    
    NSString *sig = [self generateSignatureFromDictionary:ret withSecret:kLFAPISecret];
    
    [ret setObject:sig forKey:@"api_sig"];
    
    return ret;
}

+ (NSDictionary *)generateRequestWithInfo:(NSDictionary *)info withSession:(LFSession *)session withAction:(NSString *)action{
    
//    Used for (un)loving/banning a track
    
    NSDictionary *methods = @{@"loveNowPlayingTrack": @"track.love",
                            @"loveTrack": @"track.love",
                            @"unloveNowPlayingTrack": @"track.unlove",
                            @"unloveTrack": @"track.unlove",
                            @"banNowPlayingTrack": @"track.ban",
                            @"banTrack": @"track.ban",
                            @"unbanNowPlayingTrack": @"track.unban",
                            @"unbanTrack": @"track.unban"};
    
    NSMutableDictionary *ret = [@{@"sk":session.key,
                                  @"api_key": kLFAPIKey,
                                  @"method": [methods objectForKey:action],
                                  @"artist": [[info allKeys] firstObject],
                                  @"track": [[info allValues] firstObject]} mutableCopy];
    
    NSString *sig = [self generateSignatureFromDictionary:ret withSecret:kLFAPISecret];
    
    [ret setObject:sig forKey:@"api_sig"];
    
    return ret;
}


@end
