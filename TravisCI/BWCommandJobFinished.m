//
//  BWCommandJobFinished.m
//  TravisCI
//
//  Created by Bradley Grzesiak on 1/17/12.
//  Refer to MIT-LICENSE file at root of project for copyright info
//

#import "BWCommandJobFinished.h"
#import "BWCDObjectMananger.h"

@implementation BWCommandJobFinished

/*
 *
 * {
 *   build_id: 537628,
 *   finished_at: "2012-01-17T20:43:27Z",
 *   id: 537632,
 *   result: 1,
 *   status: 1
 * }
 */

- (void)jobWasFinished:(PTPusherEvent *)event
{
    NSDictionary *jobDictionary = [event data];
    [BWCDObjectMananger updateJobFromDictionary:jobDictionary];
}

@end
