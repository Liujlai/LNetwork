//
//  IconViewController.m
//  LNetwork
//
//  Created by idea on 2018/4/12.
//  Copyright © 2018年 idea. All rights reserved.
//

#import "IconViewController.h"
#import "HXPhotoPicker.h"

#pragma mark - 选择照片

@interface IconViewController ()<HXAlbumListViewControllerDelegate>
@property (strong, nonatomic)  UIImageView *imageView;
@property (strong, nonatomic) HXPhotoManager *manager;
@property (strong, nonatomic) HXDatePhotoToolManager *toolManager;
@end

@implementation IconViewController

- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        _manager.configuration.singleSelected = YES;
        _manager.configuration.albumListTableView = ^(UITableView *tableView) {
            //            NSSLog(@"%@",tableView);
        };
        _manager.configuration.singleJumpEdit = YES;
        _manager.configuration.movableCropBox = YES;
        _manager.configuration.movableCropBoxEditSize = YES;
        //        _manager.configuration.movableCropBoxCustomRatio = CGPointMake(1, 1);
    }
    return _manager;
}
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.frame = CGRectMake(100, 100, 100, 100);
        _imageView.backgroundColor = [UIColor cyanColor];
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

- (HXDatePhotoToolManager *)toolManager {
    if (!_toolManager) {
        _toolManager = [[HXDatePhotoToolManager alloc] init];
    }
    return _toolManager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//- (void)selectedPhoto:(id)sender
{
    self.manager.configuration.saveSystemAblum = YES;
    
    __weak typeof(self) weakSelf = self;
    [self hx_presentAlbumListViewControllerWithManager:self.manager done:^(NSArray<HXPhotoModel *> *allList, NSArray<HXPhotoModel *> *photoList, NSArray<HXPhotoModel *> *videoList, BOOL original, HXAlbumListViewController *viewController) {
        if (photoList.count > 0) {
            //            HXPhotoModel *model = photoList.firstObject;
            //            weakSelf.imageView.image = model.previewPhoto;
            [weakSelf.view showLoadingHUDText:@"获取图片中"];
            [weakSelf.toolManager getSelectedImageList:photoList requestType:0 success:^(NSArray<UIImage *> *imageList) {
                [weakSelf.view handleLoading];
                weakSelf.imageView.image = imageList.firstObject;
            } failed:^{
                [weakSelf.view handleLoading];
                [weakSelf.view showImageHUDText:@"获取失败"];
            }];
            NSSLog(@"%ld张图片",photoList.count);
        }else if (videoList.count > 0) {
            [weakSelf.toolManager getSelectedImageList:allList success:^(NSArray<UIImage *> *imageList) {
                weakSelf.imageView.image = imageList.firstObject;
            } failed:^{
                
            }];
            
            // 通个这个方法将视频压缩写入临时目录获取视频URL  或者 通过这个获取视频在手机里的原路径 model.fileURL  可自己压缩
            [weakSelf.view showLoadingHUDText:@"视频写入中"];
            [weakSelf.toolManager writeSelectModelListToTempPathWithList:videoList success:^(NSArray<NSURL *> *allURL, NSArray<NSURL *> *photoURL, NSArray<NSURL *> *videoURL) {
                NSSLog(@"%@",videoURL);
                [weakSelf.view handleLoading];
            } failed:^{
                [weakSelf.view handleLoading];
                [weakSelf.view showImageHUDText:@"写入失败"];
                NSSLog(@"写入失败");
            }];
            NSSLog(@"%ld个视频",videoList.count);
        }
    } cancel:^(HXAlbumListViewController *viewController) {
        NSSLog(@"取消了");
    }];
}
- (void)albumListViewController:(HXAlbumListViewController *)albumListViewController didDoneAllList:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photoList videos:(NSArray<HXPhotoModel *> *)videoList original:(BOOL)original {
    if (photoList.count > 0) {
        HXPhotoModel *model = photoList.firstObject;
        self.imageView.image = model.previewPhoto;
        NSSLog(@"%ld张图片",photoList.count);
    }else if (videoList.count > 0) {
        __weak typeof(self) weakSelf = self;
        [self.toolManager getSelectedImageList:allList success:^(NSArray<UIImage *> *imageList) {
            weakSelf.imageView.image = imageList.firstObject;
        } failed:^{
            
        }];
        
        // 通个这个方法将视频压缩写入临时目录获取视频URL  或者 通过这个获取视频在手机里的原路径 model.fileURL  可自己压缩
        [self.view showLoadingHUDText:@"视频写入中"];
        [self.toolManager writeSelectModelListToTempPathWithList:videoList success:^(NSArray<NSURL *> *allURL, NSArray<NSURL *> *photoURL, NSArray<NSURL *> *videoURL) {
            NSSLog(@"%@",videoURL);
            [weakSelf.view handleLoading];
        } failed:^{
            [weakSelf.view handleLoading];
            [weakSelf.view showImageHUDText:@"写入失败"];
            NSSLog(@"写入失败");
        }];
        NSSLog(@"%ld个视频",videoList.count);
    }
}

@end
    
