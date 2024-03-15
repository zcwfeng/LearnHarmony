import router from '@ohos.router'
import { Header } from '../common/components/CustomComponent'
@Entry
@Component
struct Basic {
  @State message: string = 'Hello World'
  @State imageWidth: number = 50

  build() {
    Row() {
      Column() {
        Header({title:'图片查看案例'})
          .margin(10)
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        // .fontFamily("Bold")
        Divider().height(10).color(Color.Black)
        Button($r('app.media.app_icon')).margin(10)
        Button($r('app.string.next_page')).onClick(() => {
          // 跳转到第二页
          router.pushUrl({ url: 'pages/Second' }).then(() => {
            console.info('Succeeded in jumping to the second page.')
          }).catch((err) => {
            console.error(`Failed to jump to the second page.Code is ${err.code}, message is ${err.message}`)
          })
        })
        Image("https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F4d40b566-1f0a-4f8d-bc97-c513df8775b3%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1703918425&t=3aae111e402a62960fb1ee6728c1c4bd")
          .width(this.imageWidth)
        Divider().height(10).color(Color.Black)
        Image($r('app.media.app_icon')).width(this.imageWidth)
          .interpolation(ImageInterpolation.High)
        // Image($rawfile('app_icon.png'))
        TextInput({ text: this.imageWidth.toFixed(0) }).backgroundColor('#36D').width(150).type(InputType.Number).onChange(
          value => {
            console.log(value);
            this.imageWidth = parseInt(value)
          }
        )
        Slider({
          min: 30,
          max: 300,
          value: this.imageWidth,
          reverse:false
        })
          .width("90%")
          .blockColor("#36D")
          .trackThickness(7)
          .showTips(true)
          .onChange(value => {
            this.imageWidth = value
          })
      }
      .width('100%').height('100%')
    }
    .height('100%')
    .justifyContent(FlexAlign.Start)

  }
}