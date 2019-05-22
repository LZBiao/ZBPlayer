//
//  ZBPlayerWC.h
//  ZBPlayer
//
//  Created by LiZhenbiao on 2019/5/18.
//  Copyright © 2019 LiZB. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZBPlayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZBPlayerWC : NSWindowController

@property (nonatomic, strong) ZBPlayer *playerWindow;

-(void)initWindow;

@end

NS_ASSUME_NONNULL_END
