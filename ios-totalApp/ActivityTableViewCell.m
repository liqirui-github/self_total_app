//
//  ActivityTableViewCell.m
//  ios-totalApp
//
//  Created by 李其瑞 on 2020/2/26.
//  Copyright © 2020 李其瑞. All rights reserved.
//

#define MAINSCREENWIDTH [UIScreen mainScreen].bounds.size.width
#import "ActivityTableViewCell.h"
#import "ActivityModel.h"
#import "ActivityCollectionViewCell.h"
#import "Masonry/Masonry.h"

//@interface ActivityTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>
//@end

@interface ActivityTableViewCell()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation ActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withArray:(NSMutableArray*)array
{
//    NSLog(@"step 11");
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
//        NSLog(@"step 12");
//        [self createUI];
        //创建UICollectionView
        UICollectionViewFlowLayout* cvfl = [[UICollectionViewFlowLayout alloc] init];
        cvfl.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        cvfl.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*0.5, 80);
        cvfl.minimumLineSpacing = 0.0;
        UICollectionView* cv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:cvfl];
        
        cv.backgroundColor = [UIColor whiteColor];
        
//        NSLog(@"step 13");
        [cv registerClass:[ActivityCollectionViewCell class] forCellWithReuseIdentifier:@"activity"];
        cv.delegate = self;
        cv.dataSource = self;
        self.modelArray = array;
//        NSLog(@"step 14");
        [self.contentView addSubview:cv];
        
        [cv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return self;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
//    NSLog(@"index path section: %ld", indexPath.section);
    ActivityCollectionViewCell* cell = (ActivityCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"activity" forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[ActivityCollectionViewCell alloc] init];
    }
    [cell createUI:[self.modelArray objectAtIndex:indexPath.item]];
//    [cell createUI:_modelArray[indexPath.section]];
    return cell;
}


@end
