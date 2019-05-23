//
//  AppDelegate.m
//  ZBPlayer
//
//  Created by LiZhenbiao on 2019/5/17.
//  Copyright © 2019 LiZB. All rights reserved.
//

#import "AppDelegate.h"
#import "ZBPlayerWC.h"
#import "ZBPlayer.h"

@interface AppDelegate ()
//此处类型改变，同时还要修改MainMenu.xib中window的Class为自定义的window类型
@property (weak) IBOutlet NSWindow *window;

@property (nonatomic, strong) ZBPlayer *mainWindow;

@property (nonatomic, strong) ZBPlayerWC *playerWC;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    //方法1 ：
    [self windowInXIB];
    //方法3 2
//    [self windowController:0];
    
    //方法3 ：ZBPlayer *mainWindow
//    self.mainWindow = [self player];
//    [self setWindow: self.mainWindow];
}

/**
 XIB方式创建 此处类型改变，同时还要修改MainMenu.xib中window的Class为自定义的ZBPlayer类型
 注：同时还要屏蔽ZBPlayer.m中的下面这个方法，否则渲染会出现问题
 -(instancetype)initWithContentRect:(NSRect)contentRect styleMask:(NSWindowStyleMask)style backing:(NSBackingStoreType)backingStoreType defer:(BOOL)flag
 
 */
-(void)windowInXIB{
    //ZBPlayer *window;
//    [self.window initWindow];
    
    if([self.window isKindOfClass:[ZBPlayer class]]){
        ZBPlayer *tempWindow = (ZBPlayer *)self.window;
        [tempWindow initWindow];
        self.window = tempWindow;
    }
}



/**
 使用 windowController 方式创建
 遗留未解决问题，两种方法都会同时显示一个windowController  和 一个ZBPlayer类型的window
 */
-(void)windowController:(NSInteger)type{
    //ZBPlayerWC *playerWC
    self.playerWC = [[ZBPlayerWC alloc]initWithWindowNibName:@"ZBPlayerWC"];
    
    if (type == 0) {
        //方法1. 设置nib才会执行windowDidLoad方法创建
        [self setWindow:self.playerWC.window];
    }else{
        //方法2 不走windowDidLoad方法创建
        ZBPlayer *tempWindow = [self player];
        self.playerWC.window = tempWindow;
        self.window = self.playerWC.window;
    }
}


/**
 注：同时还要打开ZBPlayer.m中的下面这个方法
 -(instancetype)initWithContentRect:(NSRect)contentRect styleMask:(NSWindowStyleMask)style backing:(NSBackingStoreType)backingStoreType defer:(BOOL)flag
 */
-(ZBPlayer *)player{
    NSUInteger style =  NSWindowStyleMaskTitled | NSWindowStyleMaskClosable |NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable;
    ZBPlayer *tempWindow = [[ZBPlayer alloc]initWithContentRect:NSMakeRect(0,0,900,556) styleMask:style backing:NSBackingStoreBuffered defer:YES];
    return tempWindow;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


/**
 “关闭 window 时终止应用”
 
 @param application <#application description#>
 @return 保证当关闭最后一个window或者关闭应用唯一的一个window时应用自动退出。
 */
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)application {
    NSLog(@"最后一个窗口被关闭之后，是否终止应用");
    return NO;
}


/**
 “应用关闭后 点击 Dock 菜单再次打开应用”
 
 摘录来自: @剑指人心. “MacDev”。 iBooks.
 
 @param sender <#sender description#>
 @param flag <#flag description#>
 @return  window
 */
- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag {
    [self.window makeKeyAndOrderFront:self];
    return YES;
}


@end
