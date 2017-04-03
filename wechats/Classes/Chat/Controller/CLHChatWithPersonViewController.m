//
//  CLHChatWithPersonViewController.m
//  wechats
//
//  Created by AnICoo1 on 17/2/21.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import "CLHChatWithPersonViewController.h"
#import "CLHMessage.h"
#import "CLHChatmessageCell.h"
#import "CLHFriendInfomation.h"
#import <CoreData/CoreData.h>
#import "ChatUser+CoreDataClass.h"

@interface CLHChatWithPersonViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate,UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong) NSArray<ChatUser *> *messages;

@property(nonatomic, assign,getter=isEdit) BOOL edit;

@property(nonatomic, strong) UIPageControl *pageControl;

@property(nonatomic, strong) UIView *emojiView;

@property(nonatomic, strong) NSMutableArray *emojiDataArray;

//coreData
@property (nonatomic, strong) NSManagedObjectContext *usersChatData;
@end

static NSString * const ID = @"message";
static NSString * const emojiID = @"emoji";

@implementation CLHChatWithPersonViewController
{
    UITableView *_tableView;
    UIView *_bottomView;
    UIView *_singleLine;
    UIButton *_voiceButton;
    UITextField *_textField;
    UIButton *_emojiButton;
    UIButton *_sendMessageButton;
}

#pragma mark - 懒加载
- (NSManagedObjectContext *)usersChatData{
    if(!_usersChatData){
        _usersChatData = [self contextWithModelName:@"CLHChatData"];
    }
    return _usersChatData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpAll];
    
    self.navigationItem.title = self.friendInfo.name;
    //初始化聊天界面
    [self setUpTableView];
    
    _textField.delegate = self;
    
    // 注册键盘的通知hide or show
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    // 增加手势，点击弹回
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    [self.view addGestureRecognizer:tap];
}

#pragma mark - coreData
/**
 创建上下文对象
 */
- (NSManagedObjectContext *)contextWithModelName:(NSString *)modelName {
    // 创建上下文对象，并发队列设置为主队列
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    // 创建托管对象模型，并使用.momd路径当做初始化参数
    NSURL *modelPath = [[NSBundle mainBundle] URLForResource:modelName withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelPath];
    
    // 创建持久化存储调度器
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    // 创建并关联SQLite数据库文件，如果已经存在则不会重复创建
    NSString *dataPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    dataPath = [dataPath stringByAppendingFormat:@"/%@.sqlite", modelName];
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:dataPath] options:nil error:nil];
    
    // 上下文对象设置属性为持久化存储器
    context.persistentStoreCoordinator = coordinator;
    
    return context;
}


- (void)setUpAll{
    self.view.backgroundColor = [UIColor whiteColor];
    //底部view
    _bottomView = [[UIView alloc] init];
    _bottomView.backgroundColor = [UIColor whiteColor];
    //上部分割线
    _singleLine = [[UIView alloc]init];
    _singleLine.backgroundColor = [UIColor grayColor];
    //左侧声音按钮
    _voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_voiceButton setImage:[UIImage imageNamed:@"chat_setmode_voice_btn_normal"] forState:UIControlStateNormal];
    //输入框
    _textField = [[UITextField alloc] init];
    //表情按钮
    _emojiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_emojiButton setImage:[UIImage imageNamed:@"Album_ToolViewEmotion"] forState:UIControlStateNormal];
    [_emojiButton addTarget:self action:@selector(emojiAndText:) forControlEvents:UIControlEventTouchUpInside];
    //发送按钮
    _sendMessageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sendMessageButton setBackgroundColor:[UIColor greenColor]];
    [_sendMessageButton setTitle:@"发送" forState:UIControlStateNormal];
    [_sendMessageButton addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    _tableView = [[UITableView alloc] init];
    
    [self.view addSubview:_bottomView];
    [self.view addSubview:_tableView];
    [_bottomView addSubview:_singleLine];
    [_bottomView addSubview:_voiceButton];
    [_bottomView addSubview:_textField];
    [_bottomView addSubview:_emojiButton];
    [_bottomView addSubview:_sendMessageButton];
    
    _bottomView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0)
    .heightIs(40);
    
    _singleLine.sd_layout
    .leftSpaceToView(_bottomView, 0)
    .rightSpaceToView(_bottomView, 0)
    .topSpaceToView(_bottomView, 0)
    .heightIs(1);
    
    _tableView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .bottomSpaceToView(_bottomView, 0);
    
    _voiceButton.sd_layout
    .leftSpaceToView(_bottomView, 5)
    .topSpaceToView(_bottomView, 2)
    .bottomSpaceToView(_bottomView, 2)
    .widthIs(32);
    
    _sendMessageButton.sd_layout
    .rightSpaceToView(_bottomView, 5)
    .topSpaceToView(_bottomView, 5)
    .bottomSpaceToView(_bottomView, 5)
    .widthIs(40);
    
    _emojiButton.sd_layout
    .rightSpaceToView(_sendMessageButton, 10)
    .topSpaceToView(_bottomView, 2)
    .bottomSpaceToView(_bottomView, 2)
    .widthIs(32);
    
    _textField.sd_layout
    .leftSpaceToView(_voiceButton, 5)
    .rightSpaceToView(_emojiButton, 5)
    .topSpaceToView(_bottomView, 4)
    .bottomSpaceToView(_bottomView, 2);
    
    
}

- (void)setUpTableView{
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[CLHChatmessageCell class] forCellReuseIdentifier:ID];
    if(self.messages.count){
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (void)viewRise:(CGFloat)riseHeight{
    
    CGRect tempRec = self.view.frame;
    tempRec.origin.y = - riseHeight;
    self.view.frame = tempRec;
    _tableView.contentInset = UIEdgeInsetsMake(64 + riseHeight, 0, 0, 0);
    if(self.messages.count){
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

#pragma mark - 监听

- (void)emojiAndText:(UIButton *)sender {
    //改变按钮
    [self changeEmojiButton];
}

- (void)changeEmojiButton{
    [_textField becomeFirstResponder];
    if(self.isEdit){
        //View上移
        [self viewRise:200];
        //弹出表情键盘
        [self setUpEmojiCollectionView];
        //呼出表情
        _textField.inputView=self.emojiView;
        [_textField reloadInputViews];
        //改变按钮
        self.edit = NO;
        [_emojiButton setImage:[UIImage imageNamed:@"Album_ToolViewKeyboard"] forState:UIControlStateNormal];
        [_emojiButton setImage:[UIImage imageNamed:@"Album_ToolViewKeyboardHL"] forState:UIControlStateHighlighted];
    } else{
        self.edit = YES;
        _textField.inputView=nil;
        [_textField reloadInputViews];
        
        [_emojiButton setImage:[UIImage imageNamed:@"Album_ToolViewEmotion"] forState:UIControlStateNormal];
        [_emojiButton setImage:[UIImage imageNamed:@"Album_ToolViewEmotionHL"] forState:UIControlStateHighlighted];
    }
}

- (void)setUpEmojiCollectionView{
    
    UIView *emojiView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 200)];
    emojiView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
    self.emojiView = emojiView;
    //设置分页器
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 170, screenW, 20)];
    self.pageControl.currentPage = 1;
    self.pageControl.userInteractionEnabled = NO;
    [emojiView addSubview:self.pageControl];
    
    //collectionView布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //水平布局
    layout.scrollDirection =UICollectionViewScrollDirectionHorizontal;
    //设置每个表情按钮的大小为30*30
    layout.itemSize=CGSizeMake(30, 30);
    //计算每个分区的左右边距
    float xOffset = (screenW - 7 * 30 - 10 * 6) / 2;
    //设置分区的内容偏移
    layout.sectionInset=UIEdgeInsetsMake(10, xOffset, 10, xOffset);
    //设置行列间距
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 5;
    //UICollectionView
    UICollectionView *collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, emojiView.width, emojiView.height - 40) collectionViewLayout:layout];
    collectionV.pagingEnabled = YES;
    collectionV.showsHorizontalScrollIndicator = NO;
    [emojiView addSubview:collectionV];
    //数据源和代理
    collectionV.delegate = self;
    collectionV.dataSource = self;
    collectionV.backgroundColor = emojiView.backgroundColor;
    //注册cell
    [collectionV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:emojiID];
    
}
//发送消息
- (void)sendMessage:(UIButton *)sender {
    if (![_textField.text isEqualToString:@""])
    {
        /*
        CLHMessage *message = [[CLHMessage alloc] init];
        message.messageText = _textField.text;
        message.youself = arc4random() % 2; // 0 or 1
        [self.messages addObject:message];
         */
        
        //存入coreData
        ChatUser *user = [NSEntityDescription insertNewObjectForEntityForName:@"ChatUser" inManagedObjectContext:self.usersChatData];
        user.chatText = _textField.text;
        user.youself = arc4random() % 2;
        [self.usersChatData save:nil];

        _textField.text = @"";
    }
    self.messages = nil;
    [_tableView reloadData];
    // 滚到底部
    if (self.messages.count != 0) {
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
}

- (void)keyBoardShow:(NSNotification *)notification{
    
    CGRect rec = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 把我们整体的View往上移动
    CGRect tempRec = self.view.frame;
    tempRec.origin.y = - (rec.size.height);
    self.view.frame = tempRec;
    // 由于可见的界面缩小了，TableView也要跟着变化
    //self.tableView.y = - (rec.size.height);
    _tableView.contentInset = UIEdgeInsetsMake(64 + rec.size.height, 0, 0, 0);
    //self.tableView.frame = CGRectMake(0, - rec.size.height , 375, 667 - 64 - rec.size.height - 40);
    
    if(self.messages.count){
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (void)keyboardHide:(NSNotification *)notification{
    self.view.frame = CGRectMake(0, 0, screenW, screenH);
    _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
}

- (void)click:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
}

#pragma mark - UICollectionViewDelegate
//collection滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat contenOffset = scrollView.contentOffset.x;
    //通过滚动算出在哪一页
    int page = contenOffset / scrollView.frame.size.width + ((int)contenOffset % (int)scrollView.frame.size.width == 0 ? 0 : 1);
    self.pageControl.currentPage = page;
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    NSInteger num = (self.emojiDataArray.count / 28) + (self.emojiDataArray.count % 28 == 0 ? 0 : 1);
    self.pageControl.numberOfPages = num;
    return num;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (((self.emojiDataArray.count / 28) + (self.emojiDataArray.count % 28 == 0 ? 0 : 1)) != section + 1) {
        return 28;
    }else{
        return self.emojiDataArray.count - 28 * ((self.emojiDataArray.count / 28 ) + (self.emojiDataArray.count % 28 == 0 ? 0 : 1 ) - 1);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:emojiID forIndexPath:indexPath];
    //清空cell所有子视图
    for (NSInteger i=cell.contentView.subviews.count; i > 0; i--) {
        [cell.contentView.subviews[i-1] removeFromSuperview];
    }
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    imageV.image = [UIImage imageNamed:self.emojiDataArray[28 * indexPath.section + indexPath.row]];
    [cell.contentView addSubview:imageV];
    return cell;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * str = [NSString stringWithFormat:@"[%@]",self.emojiDataArray[indexPath.section * 28+indexPath.row]];
    //将表情添加到textField
    _textField.text = [_textField.text stringByAppendingString:str];
}

#pragma mark - UITableViewDataSource

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messages.count;
}

- (CLHChatmessageCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CLHChatmessageCell *cell = [_tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    ChatUser *userTemp = self.messages[indexPath.row];
    CLHMessage *message = [[CLHMessage alloc] init];
    message.messageText = userTemp.chatText;
    message.youself = userTemp.youself;
    
    cell.friendInfo = self.friendInfo;
    cell.superVC = self;
    [cell refreshCell:message];
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatUser *userTemp =self.messages[indexPath.row];
    
    CLHMessage *message = [[CLHMessage alloc] init];
    message.messageText = userTemp.chatText;
    message.youself = userTemp.youself;
    CGRect rec =  [message.messageText boundingRectWithSize:CGSizeMake(200, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil];
    //    NSLog(@"height = %f",rec.size.height);
    return rec.size.height + 45;
}

#pragma mark - 懒加载

- (NSArray *)messages{
    if(!_messages){
         NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ChatUser"];
        
        // 执行获取操作，获取所有Student托管对象
        _messages = [self.usersChatData executeFetchRequest:request error:nil];
    }
    return _messages;
}

- (NSMutableArray *)emojiDataArray{
    if(!_emojiDataArray){
        _emojiDataArray = [NSMutableArray array];
//        f_static_000-106
        for (int j = 0 ; j <= 106 ; j++ ) {
            NSString *name = [NSString stringWithFormat:@"f_static_%03d",j];
            [_emojiDataArray addObject:name];
        }
    }
    return _emojiDataArray;
}

@end
