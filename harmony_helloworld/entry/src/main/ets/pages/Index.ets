import router from '@ohos.router'
import hilog from '@ohos.hilog'
import { Header } from '../common/components/CustomComponent'
import http from '@ohos.net.http'
import RouterInfo from '../viewmodel/RouterInfo'
import PreferencesUtil from '../common/util/PreferencesUtil'
import IndexFontSizePanel from '../views/IndexFontSizePanel'
import RouterItem from '../views/RouterItem'

const routers: RouterInfo[] = [
  new RouterInfo('pages/Basic', '图片查看案例'),
  new RouterInfo('pages/Fourth', '商品列表'),
  new RouterInfo('pages/ListItem', 'ForEach例子'),
  new RouterInfo('pages/PropPages', '任务列表案例'),
  new RouterInfo('pages/LifeCiclePage', '组件生命周期'),
  new RouterInfo('pages/TestPage1', 'TestPage1'),
  new RouterInfo('pages/TestPage2', 'TestPage2'),
  new RouterInfo('pages/DocumentListPage', 'UIAbility启动模式案例'),
  new RouterInfo('pages/ShopPage', '查询店铺案例'),
  new RouterInfo('pages/TaskManagePage', '任务列表持久化案例'),
  new RouterInfo('pages/NotificationPage', '通知案例'),


]


@Entry
@Component
struct Index {
  @State message: string = '页面列表'
  @State showPanel: boolean = false
  @Provide fontSize: number = 16

  build() {
    Column() {
      // Header({ title: '目录列表', hideLeft: true, hideRefresh: true })
      this.Title()
      this.RouterList()

      // 字体修改面板
      if (this.showPanel) {
        IndexFontSizePanel()
          .transition({
            translate: { y: 115 }
          })
      }
    }
    .height('100%')
    .width('100%')
  }

  @Builder
  RouterList() {
    List({ space: 15 }) {
      ForEach(
        routers,
        (router, index) => {
          ListItem() {
            RouterItem({ r: router, i: index })
          }
        })
    }
    .width('100%')
    .layoutWeight(1)
    .alignListItem(ListItemAlign.Center)
  }

  @Builder
  Title() {
    Row() {
      Text(this.message)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .height(80)
      Image($r('app.media.ic_public_settings'))
        .width(30)
        .onClick(() => {
          animateTo({ duration: 500, curve: Curve.EaseOut }, () => this.showPanel = !this.showPanel)
        })
    }
    .justifyContent(FlexAlign.SpaceAround)
    .width('100%')
  }

  private tag: string = 'Index Page'

  async aboutToAppear() {
    console.log(this.tag, 'about to appear');

    this.fontSize = await PreferencesUtil.getPreferenceValue('MyPreferences', 'IndexFontSize', 16) as number
  }

  onPageShow() {
    console.log(this.tag, 'on page show');
  }

  onBackPress() {
    console.log(this.tag, 'on back press');
  }

  onPageHide() {
    console.log(this.tag, 'on page hide');
  }

  aboutToDisappear() {
    console.log(this.tag, 'about to disppear');
  }
}



