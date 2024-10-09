// import { router } from '@kit.ArkUI'
import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from '@ohos/routermodule';

@Entry({ routeName:'footprint' })
@Component
// 个人中心足迹页面
export struct Footprint {
  private arr1: number[] = [1, 2, 3, 4];
  private arr2: number[] = [];
  private arr3: number[] = [1];
  private arr4: number[] = [1, 2];
  @State private userProfile: string = '';
  @State private selectedButtonIndex: number = 0; // 将 selectedButtonIndex 状态提升到 Footprint
  @State private selectedArray: number[] = this.arr1; // 默认选中第一个数组
  @State likedItems: Set<number> = new Set();
  @State likeCounts: Map<number, number> = new Map();
  bottomRectHeight: string = AppStorage.get<number>('bottomRectHeight') + 'px';
  statusBarHeight: string = AppStorage.get<number>('statusBarHeight') + 'px';


  dialogController: CustomDialogController | null = new CustomDialogController({
    builder: CustomDialogExample({
      cancel: () => {
        this.onCancel()
      },
      confirm: (selectedIndex: number) => {
        this.onAccept(selectedIndex)
      },
      selectedButtonIndex: this.selectedButtonIndex, // 传递当前选中的按钮索引
      setSelectedButtonIndex: (index: number) => {
        this.selectedButtonIndex = index
      } // 传递一个更新函数
    }),
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    customStyle: false,
    cornerRadius: {
      topLeft: '15vp',
      topRight: '15vp',
      bottomLeft: '0vp',
      bottomRight: '0vp'
    },
    width: '107%',
    height: 400,
    maskColor: 0x99000000,
    backgroundColor: 0xffffff,
    // shadow: ({ radius: 20, color: Color.Grey, offsetX: 50, offsetY: 0}),
  })

  // 初始化弹窗控制器
  textDialogController: CustomDialogController | null = new CustomDialogController({
    builder: TextCustomDialog({
      confirm: (text: string) => {
        this.userProfile = text; // 更新个人简介文本
      },
      text: this.userProfile // 将当前简介传递给 TextCustomDialog
    }),
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    customStyle: false,
    cornerRadius: {
      topLeft: '15vp',
      topRight: '15vp',
      bottomLeft: '0vp',
      bottomRight: '0vp'
    },
    width: '107%',
    height: 370,
    maskColor: 0x99000000,
    backgroundColor: 0xffffff,
  })

  // 在自定义组件即将析构销毁时将dialogController置空
  aboutToDisappear() {
    this.dialogController = null // 将dialogController置空
  }

  onCancel() {
    console.info('Callback when the first button is clicked')
  }

  onAccept(selectedIndex: number) {
    console.info('Callback when the second button is clicked')
    this.selectedButtonIndex = selectedIndex; // 更新按钮选中状态
    switch (selectedIndex) {
      case 0:
        this.selectedArray = this.arr1;
        break;
      case 1:
        this.selectedArray = this.arr2;
        break;
      case 2:
        this.selectedArray = this.arr3;
        break;
      case 3:
        this.selectedArray = this.arr4;
        break;
    }

  }

  build() {
    Flex({ direction: FlexDirection.Column }) {
      Column() {
        Row() {
          Image($r('app.media.left_back'))
            .width(17)
            .height(17)
            .align(Alignment.Start)
            .onClick(() => {
              RouterModule.pop(RouterNameConstants.ME_HAR)
              // router.replaceNamedRoute({
              //   name: 'MainPage'
              // })
            })

          Row() {
            Image($r('app.media.share'))
              .width(15)
              .height(15)
              .align(Alignment.Start)

            Blank()
              .width(10)

            Image($r('app.media.manage'))
              .width(22)
              .height(22)
              .align(Alignment.Start)
          }
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .height('10%')
        .width('90%')

        Blank()
          .height(30)

        Column({ space: 3 }) {
          Row() {
            Image($r('app.media.startIcon'))
              .width(65)
              .height(65)
              .borderRadius(50)
              .align(Alignment.Start)
          }
          .width('100%')
          .margin({ bottom: 15 })

          Row() {
            Text('用户名')
              .fontSize(17)
              .align(Alignment.Start)
          }
          .width('100%')

          Blank()
            .height(5)

          Row() {
            Button() {
              Row() {
                Text('设置知识号')
                  .fontSize(11)
                  .align(Alignment.Start)
                  .fontColor(Color.Gray)

                Blank()
                  .width(5)

                Image($r('app.media.knowledge_number'))
                  .width(13)
                  .height(13)
                  .align(Alignment.Start)
              }
              .width('100%')
            }
            .stateEffect(false)
            .backgroundColor(Color.Transparent)
            .width('50%')
          }
          .width('100%')

          Blank()

          Row() {
            Text('IP所属地：广东')
              .fontSize(11)
              .align(Alignment.Start)
              .fontColor(Color.Gray)
          }
          .width('100%')
          .margin({ bottom: 7 })

          Row() {
            Button() {
              Text(this.userProfile === '' ? '你还没有填写个人简介，点击添加...' : this.userProfile)
                .fontSize(11)
                .align(Alignment.Start)
                .fontColor(this.userProfile === '' ? 0x5b758e : Color.Gray)
            }
            .stateEffect(false)
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              if (this.textDialogController != null) {
                this.textDialogController.open();
              } else {
                console.error("textDialogController is not initialized.");
              }
            })

            if (this.userProfile !== '') {
              Image($r('app.media.right_arrow'))
                .width(12)
                .height(13)
                .onClick(() => {
                  if (this.textDialogController != null) {
                    this.textDialogController.open();
                  }
                })
                .margin({ left: 2 })
            }
          }
          .width('100%')

        }
        .width('90%')
        .margin({ bottom: 10 })

        Blank()
          .height(1)
          .width('100%')
          .color(0xf5f5f5)

        Row() {
          Row() {
            Text('我关注的人')
              .fontSize(12)
              .align(Alignment.Start)
              .fontColor(Color.Gray)
            Text('1')
              .fontSize(12)
              .align(Alignment.Start)
          }

          Blank()
            .width(20)

          Row() {
            Text('关注我的人')
              .fontSize(12)
              .align(Alignment.Start)
              .fontColor(Color.Gray)
            Text('0')
              .fontSize(12)
              .align(Alignment.Start)
          }

        }
        .width('90%')
        .height('13%')

        Blank()
          .height(3)
          .width('100%')
          .color(0xf5f5f5)

        Row() {
          Button() {
            Row() {
              Text('全部')
                .fontSize(12)
                .align(Alignment.Start)
                .fontColor(0x5b758e)

              Blank()
                .width(5)

              Image($r('app.media.down_arrow'))
                .width(10)
                .height(10)
                .align(Alignment.Start)
            }
          }
          .backgroundColor(0xf3f7f8)
          .width(65)
          .height(25)
          .onClick(() => {
            if (this.dialogController != null) {
              this.dialogController.open()
            }
          })

          Text('共 ' + this.selectedArray.length + ' 条内容')
            .fontSize(12)
            .align(Alignment.Start)
            .fontColor(Color.Gray)

        }
        .width('90%')
        .height('13%')
        .justifyContent(FlexAlign.SpaceBetween)

        Blank()
          .height(1)
          .width('100%')
          .color(0xf5f5f5)
      }
      .height('75%')

      Row() {
        //如果没有私信，就显示没有私信，有私信就显示私信
        if (this.selectedArray.length == 0) {
          Column() {
            Image($r('app.media.no_notes'))
              .width(120)
              .height(100)

            Blank()
              .height(10)

            Text("这里空空如也")
              .fontSize(15)// .fontWeight(FontWeight.Bold)
                // .textAlign(TextAlign.Center)
              .fontColor(Color.Gray)
          }
          .width('100%')
          .height('40%')

        } else {
          Column() {
            List() {
              ForEach(this.selectedArray, (item: number) => {
                ListItem() {
                  Column() {
                    Row() {
                      Image($r('app.media.startIcon'))
                        .width(25)
                        .height(25)
                        .borderRadius(25)
                        .align(Alignment.TopStart)
                        .zIndex(1)
                        .alignSelf(ItemAlign.Start)
                        .border({
                          width: 0.5,
                          color: 0xe6e6e6
                        })

                      Blank()
                        .width(10)

                      Column() {
                        Column() {
                          Row() {
                            Text('发布了观点')
                              .fontSize(10)
                              .fontColor(Color.Gray)
                          }

                          Blank()
                            .height(3)

                          Row() {
                            Text('2021-08-01')
                              .fontColor(Color.Gray)
                              .fontSize(10)
                          }
                        }
                        .width('80%')
                        .alignItems(HorizontalAlign.Start)

                        Blank()
                          .height(5)

                        Row() {
                          Text('HarmonyOS NEXT Beta 版本鸿蒙应用开发视频教程来了，由于平台暂时无法提交视频，需要达到一定人数，所以目前提供哗哩哔哩视频链接供大家学习，后期会在星球持续更新，学习内容包含 环境搭建、ArkTS语法、ArkUI组件、Ability开发、服务卡片、数据管理、文件管理、网络请求、分布式特性、项目等知识点，祝大家学习愉快!!!')
                            .fontSize(14)
                            .lineHeight(20)
                            .maxLines(3)
                            .textOverflow({ overflow: TextOverflow.Ellipsis })
                        }
                        .width('80%')

                        Blank()
                          .height(10)

                        Column() {
                          Row() {
                            Row() {
                              Button({ type: ButtonType.Normal }) {
                                Row() {
                                  Image($r('app.media.startIcon'))
                                    .width(15)
                                    .height(15)
                                    .align(Alignment.Start)

                                  Blank()
                                    .width(5)

                                  Text('test')
                                    .fontSize(11)
                                    .height(20)
                                    .fontColor(0x5b758e)
                                }

                              }
                              .width(55)
                              .height(25)
                              .borderRadius(5)
                              .backgroundColor(0xf3f7f8)
                            }

                            Row() {
                              Row() {
                                Button() {
                                  Row() {
                                    Button() {
                                      Image($r(this.likedItems.has(item) ? 'app.media.like_true' :
                                        'app.media.like_false'))
                                        .width(17)
                                        .height(17)
                                        .backgroundColor(Color.White)
                                    }
                                    .onClick(() => {
                                      if (this.likedItems.has(item)) {
                                        this.likedItems.delete(item);
                                        this.likeCounts.set(item, (this.likeCounts.get(item) || 1) - 1);
                                      } else {
                                        this.likedItems.add(item);
                                        this.likeCounts.set(item, (this.likeCounts.get(item) || 0) + 1);
                                      }
                                    })

                                    Blank()
                                      .width(5)
                                    Text(`${this.likeCounts.get(item) || ''}`)
                                      .fontSize(10)
                                      .fontWeight(FontWeight.Normal)
                                      .fontColor(this.likedItems.has(item) ? 0x18b998 : 0x65768c)
                                  }
                                }
                                .stateEffect(false)
                                .backgroundColor(Color.Transparent)

                                Blank()
                                  .width(20)

                                Button() {
                                  Row() {
                                    Image($r('app.media.comment'))
                                      .width(15)
                                      .height(15)
                                  }
                                }
                                .backgroundColor(Color.Transparent)
                              }

                              Blank()
                                .width(10)
                            }
                          }
                          .width('80%')
                          .justifyContent(FlexAlign.SpaceBetween)
                        }
                        .justifyContent(FlexAlign.SpaceBetween)
                      }
                    }
                  }
                }
                .margin({ top: 15, bottom: 15 })
                .align(Alignment.Center)
                .width('100%')
              })
            }
            .width('100%')
            .height('auto')
            .listDirection(Axis.Vertical) // 排列方向
            .scrollBar(BarState.Off)
            .divider({
              strokeWidth: 2,
              color: 0xf5f6f8,
              // startMargin: 15,
              // endMargin: 15
            }) // 每行之间的分界线

            Blank()
              .height(1)
              .color(0xf5f6f8)
              .width('100%')

            Blank()
              .height(12)

            Row() {
              Text('没有更多数据')
                .fontSize(12)
                .fontColor(Color.Gray)
                .textAlign(TextAlign.Center)
                .width('100%')
            }
          }
          .alignItems(HorizontalAlign.Start)
          .height('100%');
        }
      }
      .width('100%')
      .height('100%')
    }
    .padding({
      top: this.statusBarHeight
    })  }
}

@CustomDialog
struct CustomDialogExample {
  controller?: CustomDialogController
  cancel: () => void = () => {}
  confirm: (selectedIndex: number) => void = () => {} // 确保confirm函数定义接受一个参数
  selectedButtonIndex: number = 0; // 接收 Footprint 中传递的 selectedButtonIndex
  setSelectedButtonIndex: (index: number) => void = () => {}; // 接收用于更新 selectedButtonIndex 的函数

  build() {

    Column() {
      Blank().height(15);

      // 按钮 1
      Button() {
        Row() {
          Text('全部')
            .fontSize(13)
            .align(Alignment.Start)
            .fontColor(this.selectedButtonIndex === 0 ? 0x25b196 : 0x000000); // 选中时改变颜色

          Row() {
            if (this.selectedButtonIndex === 0) {
              Image($r('app.media.selected'))// 假设有一个选中标志图标
                .width(20)
                .height(20)
                .align(Alignment.End);
            }
          }
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween);
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.White)
      .borderRadius(5)
      .width('90%')
      .height(40)
      .onClick(() => {
        this.setSelectedButtonIndex(0);
        this.confirm(0);
        this.controller?.close(); // 关闭弹窗
      });

      // 按钮 2
      Button() {
        Row() {
          Row() {
            Image($r('app.media.startIcon'))
              .width(20)
              .height(20)
              .align(Alignment.End);

            Text('星空笔记')
              .fontSize(13)
              .align(Alignment.Start)
              .margin(10)
              .fontColor(this.selectedButtonIndex === 1 ? 0x25b196 : 0x000000); // 选中时改变颜色
          }

          Row() {
            if (this.selectedButtonIndex === 1) {
              Image($r('app.media.selected'))// 假设有一个选中标志图标
                .width(20)
                .height(20)
                .align(Alignment.End);
            }
          }
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%');
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.White)
      .borderRadius(5)
      .width('90%')
      .height(50)
      .onClick(() => {
        this.setSelectedButtonIndex(1);
        this.confirm(1);
        this.controller?.close(); // 关闭弹窗
      });

      Blank()
        .height(1)
        .width('90%')
        .color(0xf5f5f5);

      // 按钮 3
      Button() {
        Row() {
          Row() {
            Image($r('app.media.startIcon'))
              .width(20)
              .height(20)
              .align(Alignment.End);

            Text('鸿蒙学习社区(HarmonyOS Next)')
              .fontSize(13)
              .align(Alignment.Start)
              .margin(10)
              .fontColor(this.selectedButtonIndex === 2 ? 0x25b196 : 0x000000); // 选中时改变颜色
          }

          Row() {
            if (this.selectedButtonIndex === 2) {
              Image($r('app.media.selected'))// 假设有一个选中标志图标
                .width(20)
                .height(20)
                .align(Alignment.End);
            }
          }
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%');
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.White)
      .borderRadius(5)
      .width('90%')
      .height(50)
      .margin({ top: 10 })
      .onClick(() => {
        this.setSelectedButtonIndex(2);
        this.confirm(2);
        this.controller?.close(); // 关闭弹窗
      });

      // 按钮 4
      Button() {
        Row() {
          Row() {
            Image($r('app.media.startIcon'))
              .width(20)
              .height(20)
              .align(Alignment.End);

            Text('test')
              .fontSize(13)
              .align(Alignment.Start)
              .margin(10)
              .fontColor(this.selectedButtonIndex === 3 ? 0x25b196 : 0x000000); // 选中时改变颜色
          }

          Row() {
            if (this.selectedButtonIndex === 3) {
              Image($r('app.media.selected'))// 假设有一个选中标志图标
                .width(20)
                .height(20)
                .align(Alignment.End);
            }
          }
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%');
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.White)
      .borderRadius(5)
      .width('90%')
      .height(50)
      .onClick(() => {
        this.setSelectedButtonIndex(3);
        this.confirm(3);
        this.controller?.close(); // 关闭弹窗
      });
    }
  }
}

@CustomDialog
struct TextCustomDialog {
  controller?: CustomDialogController;
  cancel: () => void = () => {};
  confirm: (text: string) => void = () => {};
  @State text: string = ''; // 初始值为空
  textController: TextInputController = new TextInputController();

  build() {
    Column() {
      Row() {
        Column() {
          Row() {
            Button() {
              Text('取消')
                .fontSize(14)
                .fontColor(Color.Gray)
            }
            .stateEffect(false)
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              this.controller?.close()
            });

            Text('个人简介')
              .fontSize(16)
              .fontColor(0x000000)
              .margin(10);

            Button() {
              Text('完成')
                .fontSize(14)
                .fontColor(0x25b196)
            }
            .stateEffect(false)
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              this.confirm(this.text); // 将文本传递给 confirm 回调函数
              this.controller?.close()
            });
          }
          .width('90%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
      }
      .height(50)

      Blank()
        .height(1)
        .width('100%')
        .color(0xf5f5f5);

      Blank()
        .height(10)

      TextArea({ placeholder: '有趣的简介可以吸引关注', text: this.text, controller: this.textController })
        .placeholderFont({ size: 14 })
        .width('99%')
        .height(300)
        .maxLength(60)
        .maxLines(10)
        .fontSize(14)
        .caretColor(0x25b196)
        .backgroundColor(Color.Transparent)
        .showCounter(true, { thresholdPercentage: 1, highlightBorder: false })
        .onChange((value: string) => {
          this.text = value;
        });
    }
  }
}

@Builder function harBuilder(value: object) {
  NavDestination() {
    Footprint()
  }
  .hideTitleBar(true)
  .ignoreLayoutSafeArea([LayoutSafeAreaType.SYSTEM], [LayoutSafeAreaEdge.TOP, LayoutSafeAreaEdge.BOTTOM])
}
// 注册构建器
const builderName = BuilderNameConstants.HARME_FOOTPRINT;
// 如果没有注册过，则注册
if (!RouterModule.getBuilder(builderName)) {
  let builder: WrappedBuilder<[object]> = wrapBuilder(harBuilder);
  RouterModule.registerBuilder(builderName, builder);
}
