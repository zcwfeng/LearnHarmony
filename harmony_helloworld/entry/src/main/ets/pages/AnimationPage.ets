@Entry
@Component
struct AnimationPage {
  @State message: string = '^_^'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .transition({
            opacity: 0,
            rotate: { angle: -360 },
            scale: { x: 0, y: 0 }
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}