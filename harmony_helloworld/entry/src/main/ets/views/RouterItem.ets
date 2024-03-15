import router from '@ohos.router'
import RouterInfo from '../viewmodel/RouterInfo'

@Component
export default struct RouterItem {
  r: RouterInfo
  i: number
  @Consume fontSize: number

  build() {
    Row() {
      Text(this.i + 1 + '.')
        .fontSize(this.fontSize)
        .fontColor(Color.White)
      Blank()
      Text(this.r.title)
        .fontSize(this.fontSize)
        .fontColor(Color.White)

    }
    .width('90%')
    .padding(12)
    .backgroundColor('#38f')
    .borderRadius(20)
    .shadow({ radius: 6, color: '#4f000000', offsetX: 2, offsetY: 6 })
    .onClick(() => {
      // hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
      // hilog.info(0x0001, 'testTag', '%{private}s', 'Ability onCreate');

      router.pushUrl(
        {
          url: this.r.url,
          params: { id: this.i + 1}
        },
        router.RouterMode.Single,
        err => {
          if (err) {
            console.log(`路由失败，errorCode：${err.code} errMsg:${err.message}`)
          }
        }
      )
    })
  }
}