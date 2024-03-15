import router from '@ohos.router'

@Entry
@Component
struct TestPage1 {
  @State message: string = 'Test Page 1'

  private tag: string = 'Test Page 1'
  aboutToAppear() {
    console.log(this.tag, 'about to appear');
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
    console.log(this.tag,'about to disppear');
  }

  build() {
    Column() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }.width('100%')

      Row() {
        Button('push Page2')
          .margin(5)
          .onClick(() => router.pushUrl({ url: 'pages/TestPage2' }))
        Button('replace Page2')
          .margin(5)
          .onClick(() => router.replaceUrl({ url: 'pages/TestPage2' }))
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
    }
    .justifyContent(FlexAlign.Center)
    .height('100%')
  }
}