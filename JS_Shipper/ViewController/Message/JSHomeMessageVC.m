//
//  JSHomeMessageVC.m
//  JS_Driver
//
//  Created by Jason_zyl on 2019/3/6.
//  Copyright © 2019 Jason_zyl. All rights reserved.
//

#import "JSHomeMessageVC.h"
#import "EaseMessageViewController.h"

@interface JSHomeMessageVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JSHomeMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    self.baseTabView.delegate = self;
    self.baseTabView.dataSource = self;
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageHomeTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageHomeTabCell2"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //环信ID:@"8001"
    //聊天类型:EMConversationTypeChat
    EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:@"15737936517" conversationType:EMConversationTypeChat];
    [self.navigationController pushViewController:chatController animated:YES];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
@implementation MessageHomeTabCell

@end
