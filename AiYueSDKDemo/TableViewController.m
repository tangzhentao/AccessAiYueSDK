//
//  TableViewController.m
//  AiYueSDKDemo
//
//  Created by itang on 2017/12/12.
//  Copyright © 2017年 guangying_tang. All rights reserved.
//

#import "TableViewController.h"
#import "ShareTypeModel.h"
#import "AiYueSDK.h"

extern const NSString *AiYueAppId;

/* 分享扩展链接的扩展字段 */
const NSString *KInviterId = @"InviterId"; // 邀请人id
const NSString *KInviterName = @"InviterName";// 邀请名字
const NSString *KGameRoomId = @"GameRoomId";// 游戏房间id

static NSString *UITableViewCellID = @"UITableViewCellID";

@interface TableViewController ()

@property (strong, nonatomic) NSArray *dataArray;
@property (assign, nonatomic) AYScene scene;


@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    [self setupData];

}

- (void)setupUI
{
    self.title = @"分享给好友";
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
   /*
    分享到朋友圈功能已经移除
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享到朋友圈" style:0 target:self
    action:@selector(switchScene)];
    */

    
    [self configTableview];
}
- (void)switchScene
{
    if (AYSceneSession == _scene) {
        _scene = AYSceneTimeline;
        self.title = @"分享到朋友圈";
        self.navigationItem.rightBarButtonItem.title = @"分享给好友";

    } else {
        _scene = AYSceneSession;
        self.title = @"分享给好友";
        /*
         分享到朋友圈功能已经移除
         self.navigationItem.rightBarButtonItem.title = @"分享到朋友圈";
         */

    }
}

- (void)setupData
{
    // 默认分享给好友
    _scene = AYSceneSession;
    _dataArray = @[[ShareTypeModel modelWithName:@"授权登录" type:ShareTypeLogin],
                   [ShareTypeModel modelWithName:@"分享图片" type:ShareTypeImageObject],
                   [ShareTypeModel modelWithName:@"分享链接" type:ShareTypeLink],
                   [ShareTypeModel modelWithName:@"分享带扩展链接" type:ShareTypeLinkWithExt],
                   [ShareTypeModel modelWithName:@"检测是否安装了爱约" type:ShareTypeInstalled],
                   ];
}

- (void)configTableview
{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:UITableViewCellID];
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCellID];
    ShareTypeModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShareTypeModel *model = self.dataArray[indexPath.row];
    ShareType type = model.type;
    if (ShareTypeLogin == type)
    {/* 授权登录 */
        
        // 1. 创建一个授权登录请求
        AYAuthorizeLoginRequest *request = [AYAuthorizeLoginRequest new];
        // 2. 发送授权登录请求
        [[AiYueSDK defaultService] sendRequest:request completion:^(AYResponse *response) {
        // 3.在这里处理授权结果
            if (AYErrorTypeNone == response.errorType)
            {// 授权成功
                NSLog(@"授权成功");
                if ([response isKindOfClass:[AuthorizeLoginResponse class]])
                {
                    // 4.获取openId
                    NSString *openId = [(AuthorizeLoginResponse *)response openId];
                    NSLog(@"openId: %@", openId);
                     // 5.获取爱约用户基本信息
                    [self requestUserInfoWithAppId:AiYueAppId OpenId:openId];
                }
                
            } else if (AYErrorTypeUserCancell == response.errorType)
            {// 用户取消了授权
                NSLog(@"用户取消了授权");
            } else
            {// 授权失败
                NSLog(@"授权失败");
            }
        }];
    } else if ((ShareTypeImageObject == type))
    {/* 分享图片 */
        
        // 1. 创建一个分享图片的请求
        AYShareImageRequest *request = [AYShareImageRequest new];
        // 分享的图片必须是UIImage类的对象
        request.image = [UIImage imageNamed:@"feature1_"];
        // 2. 发送该请求
        [[AiYueSDK defaultService] sendRequest:request completion:^(AYResponse *response) {
        // 3. 在这里处理分享图片结果
            if (AYErrorTypeNone == response.errorType)
            {// 分享图片成功
                NSLog(@"分享图片成功");
                
            } else if (AYErrorTypeUserCancell == response.errorType)
            {// 用户取消了分享图片
                NSLog(@"用户取消了分享图片");
            } else
            {// 分享图片失败
                NSLog(@"分享图片失败");
            }
        }];
    } else if ((ShareTypeLink == type))
    {/* 分享链接 */
        
        // 1. 创建一个分享链接的请求
        AYShareLinkRequest * request = [AYShareLinkRequest new];
        request.linkAdress = @"http://www.45666.com/";
        request.thumbnailImage = @"http://imagecdn.663550.com/image/user/avatar/2018/12/21/e34d81aac656af7b492f72f25dba5bf4.jpg"; // 受网易自定义消息中attachment500字节限制，该属性只能传nsstring
        request.title = @"这是分享链接的标题";
        request.content = @"这是分享链接的内容，是对分享内容精明扼要的介绍。";

        // 2. 发送该请求
        [[AiYueSDK defaultService] sendRequest:request completion:^(AYResponse *response) {
        // 3. 在这里处理分享链接结果
            if (AYErrorTypeNone == response.errorType)
            {// 分享链接成功
                NSLog(@"分享链接成功");
            } else if (AYErrorTypeUserCancell == response.errorType)
            {// 用户取消了分享链接
                NSLog(@"用户取消了分享链接");
            } else
            {// 分享链接失败
                NSLog(@"分享链接失败");
            }
        }];
    } else if ((ShareTypeLinkWithExt == type))
    {/* 分享带扩展链接 */
        
         // 1. 创建一个分享带扩展链接的请求
        AYShareLinkRequest * request = [AYShareLinkRequest new];
        request.linkAdress = @"http://www.45666.com/";
        request.thumbnailImage = @"http://imagecdn.663550.com/image/user/avatar/2018/12/21/e34d81aac656af7b492f72f25dba5bf4.jpg"; // 受网易自定义消息中attachment500字节限制，该属性只能传nsstring
        request.title = @"房间开好了，就等你了！";
        request.content = @"超好玩，房间开好了，就等你了。快！速度上车！！";
        request.ext = @{
                        KInviterId : @"someone",
                        KInviterName : @"9527",
                        KGameRoomId  : @1001,
                        };
        
        // 2. 发送该请求
        [[AiYueSDK defaultService] sendRequest:request completion:^(AYResponse *response) {
        // 3. 在这里处理分享带扩展链接的结果
            if (AYErrorTypeNone == response.errorType)
            {// 分享带扩展链接成功
                NSLog(@"分享带扩展链接成功");
            } else if (AYErrorTypeUserCancell == response.errorType)
            {// 用户取消了分享带扩展链接
                NSLog(@"用户取消了分享带扩展链接");
            } else
            {// 分享带扩展链接失败
                NSLog(@"分享带扩展链接失败");
            }
        }];
    } else if ((ShareTypeInstalled == type))
    {/* 检测是否安装了爱约 */
        BOOL installed = [AiYueSDK isAiYueInstalled];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@", installed ? @"爱约已安装" : @"爱约未安装"]
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
}

- (void)requestUserInfoWithAppId:(const NSString *)appId OpenId:(const NSString *)openId
{
    /*
     1、HTTP请求方式
     GET/POST
     2、接口地址
     http://120.76.156.189/wl/index.php/app/api/getKeyUserInfo
     3、支持格式
     JSON
     4、请求参数
     
     5、注意事项
     无
     6、返回结果
     JSON示例
     {
     "code": 1, //状态码
     "msg": "获取用户信息成功",//提示信息
     "headsmall": "http://120.76.156.189/wl/Uploads/Picture/avatar/2017/08/01/s_615887eeb059281f5de7ba8c57061000.jpg",//用户头像
     "nickname": "大芬村",//用户昵称
     "gender": "0"//性别  0男 1女 2未知
     //性别  0 未知 1 男 2女
     }
     状态码说明
     code:400非法请求
     code:401用户不存在
     code：1获取用户信息成功
     */
    
    
    NSString *urlStr = [NSString stringWithFormat:@"http://120.76.156.189/wl/index.php/app/api/getKeyUserInfo?key=%@&uid=%@", appId, openId];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (nil == error)
        {// 网络请求成功
            
            // 提取json数据
            NSDictionary *dataInfo = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            // 获取状态码
            int code = [dataInfo[@"code"] intValue];
            NSString *msg = dataInfo[@"msg"];
            NSLog(@"code[%d]: %@", code, msg);
            if (1 == code)
            { // 获取用户信息成功
                
                // 获取爱约用户昵称
                NSString *nickname = dataInfo[@"nickname"];
                // 获取爱约用户头像
                NSString *headsmall = dataInfo[@"headsmall"];

                // 获取爱约用户性别： 0 未知， 1 男， 2 女
                int gender = [dataInfo[@"gender"] intValue];
                NSLog(@"\n爱约用户基本信息:\n昵称：%@\n头像：%@\n性别：%d\n", nickname, headsmall, gender);
                
            } else if (400 == code)
            {// 非法请求
                /* 可能是appId不对 */
            } else if (401 == code)
            {// 用户不存在
                
            }
            
        } else
        {// 网络请求失败
            NSLog(@"error: %@", error);
        }
    }];
    
    [task resume];
}

@end
