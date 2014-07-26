/* scrobbled.m - Scrobbler Daemon for Apple iPhone
 * Copyright (C) 2007 Sam Steele
 *
 * This file is part of MobileScrobbler.
 *
 * MobileScrobbler is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3
 * as published by the Free Software Foundation.
 *
 * MobileScrobbler is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA
 */

#import "PBScrobbler.h"
#import "NSString+MD5.h"

int main(int argc, char *argv[]) {
    
    NSRunLoop *mainLoop;
    
    @autoreleasepool {
        
        
        mainLoop = [NSRunLoop currentRunLoop];
        PBScrobbler *scrobbler = [[PBScrobbler alloc] init];
        
        while (!(scrobbler.shouldTerminate) && [mainLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:2]]);
    }
    
    return 0;
}
