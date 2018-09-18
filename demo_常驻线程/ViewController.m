//
//  ViewController.m
//  demo_常驻线程
//
//  Created by  huzhongyin on 17/6/22.
//  Copyright © 2017年 LanGe. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) NSThread *thread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(createRunloopByNormal) object:nil] ;
    [self.thread start];
    NSLog(@"%@",[NSRunLoop currentRunLoop]);
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)createRunloopByNormal{
    @autoreleasepool {
        NSLog(@"%@",[NSRunLoop currentRunLoop]);
        //添加port源，保证runloop正常轮询，不会创建后直接退出。
        [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
        NSLog(@"test1");
        //开启runloop
        [[NSRunLoop currentRunLoop] run];
    }
}

- (IBAction)btnTest:(id)sender {
    NSLog(@"%@",self.thread);
    NSLog(@"-----btnClick--------");
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];
}
- (void)test{
    NSLog(@"----->Test");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
