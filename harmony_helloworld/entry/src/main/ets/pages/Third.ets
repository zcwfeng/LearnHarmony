@Entry
@Component
struct Third {
  @State msg: string = "Test"

  build() {

    Column({space:10}) {
      Row().height(30).width('90%').backgroundColor('#36D')//.margin(10)
      Row().height(30).width('90%').backgroundColor('#36D')//.margin(10)
      Row().height(30).width('90%').backgroundColor('#36D')//.margin(10)
    }.justifyContent(FlexAlign.Start).width('100%').height('100%')
    .alignItems(HorizontalAlign.Center)
  }
}