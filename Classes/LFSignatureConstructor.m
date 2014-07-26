
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
    
    if (!mediaItem.title || !mediaItem.artist) {
        
        return nil;
    }
    
    NSMutableDictionary *ret = [NSMutableDictionary dictionaryWithObjectsAndKeys:session.key, @"sk", kLFAPIKey, @"api_key", method, @"method", nil];
    
    [ret setObject:mediaItem.title forKey:@"track"];
    [ret setObject:mediaItem.artist forKey:@"artist"];
    
    if ([mediaItem.timestamp longValue]){
        [ret setObject:[NSString stringWithFormat:@"%ld", [mediaItem.timestamp  longValue]] forKey:@"timestamp"];
    }
    
    if (mediaItem.album) {
        [ret setObject:mediaItem.album forKey:@"album"];
    }
    
    if (mediaItem.duration) {
        [ret setObject:[NSString stringWithFormat:@"%ld", (unsigned long)mediaItem.duration] forKey:@"duration"];
    }
    
    NSString *sig = [self generateSignatureFromDictionary:ret withSecret:kLFAPISecret];
    
    [ret setObject:sig forKey:@"api_sig"];
    
    return ret;
}

+ (NSDictionary *)generateParametersWithMediaItems:(NSArray *)mediaItems withSession:(LFSession *)session withMethod:(NSString *)method{
    
    NSMutableDictionary *ret = [NSMutableDictionary dictionaryWithObjectsAndKeys:session.key, @"sk", kLFAPIKey, @"api_key", method, @"method", nil];
    
    unsigned int i = 0;
    for (PBMediaItem *mediaItem in mediaItems) {
        
        [ret setObject:mediaItem.title forKey:[NSString stringWithFormat:@"track[%d]", i]];
        [ret setObject:mediaItem.artist forKey:[NSString stringWithFormat:@"artist[%d]", i]];
        
        [ret setObject:[NSString stringWithFormat:@"%ld", (unsigned long)mediaItem.timestamp] forKey:[NSString stringWithFormat:@"timestamp[%d]", i]];
        
        if (mediaItem.album) {
            [ret setObject:mediaItem.album forKey:[NSString stringWithFormat:@"album[%d]", i]];
        }
        
        if (mediaItem.duration) {
            [ret setObject:[NSString stringWithFormat:@"%ld", (unsigned long)mediaItem.duration] forKey:[NSString stringWithFormat:@"duration[%d]",i]];
        }
       
        i++;
    }
    
    NSString *sig = [self generateSignatureFromDictionary:ret withSecret:kLFAPISecret];
    
    [ret setObject:sig forKey:@"api_sig"];
    
    return ret;
}

@end
