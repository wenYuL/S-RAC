//
//  ViewController.m
//  RACSignal
//
//  Created by wenYuL on 2017/12/7.
//  Copyright © 2017年 wenYuL. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createAndSendSignal];
}

/**
 创建、发送、接收信号
 */
- (void)createAndSendSignal {
    //创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //发送信号
        //1.发送一般信号，发送信号类型为id
        [subscriber sendNext:@"发送信号"];
        //2.发送错误信号
        [subscriber sendError:[NSError errorWithDomain:@"domain" code:23 userInfo:@{@"errorCode":@"error"}]];
        //3.发送complete信号
        [subscriber sendCompleted];
        /*  1.可返回RACDisposable对象
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"取消订阅");
        }];
        */
        /*   2.也可返回nil
         */
        return nil;
    }];
    
    //订阅信号
    //发送信号的方式有三种，订阅信号的方式也对应有三种；要想接收到相应类型的信号，
    //则必须实现相应的订阅信号方法
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收到信号：%@",x);
    }];
    [signal subscribeError:^(NSError * _Nullable error) {
        NSLog(@"接收到错误信号%@",error);
    }];
    [signal subscribeCompleted:^{
        NSLog(@"接收到complete信号");
    }];
}
- (IBAction)pushNewVC:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
