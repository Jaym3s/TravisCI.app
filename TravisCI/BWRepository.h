//
//  BWRepository.h
//  TravisCI
//
//  Created by Bradley Grzesiak on 12/20/11.
//  Refer to MIT-LICENSE file at root of project for copyright info
//

#import "BWPresenter.h"

@interface BWRepository : BWPresenter

- (NSString *)durationText;
- (NSString *)finishedText;
- (void)fetchBuilds;

@property (nonatomic, retain) NSNumber *remote_id;
@property (nonatomic, retain) NSString *slug;
@property (nonatomic, retain) NSString *last_build_number;
@property (nonatomic, retain) NSNumber *last_build_status;
@property (nonatomic, retain) NSNumber *last_build_result;
@property (nonatomic, retain) NSNumber *last_build_id;
@property (nonatomic, retain) NSNumber *last_build_duration;
@property (nonatomic, retain) NSDate *last_build_started_at;
@property (nonatomic, retain) NSDate *last_build_finished_at;

@end
