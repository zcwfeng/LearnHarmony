import router from '@ohos.router'
@Entry
@Component
struct TestPage2 {
  @State message: string = 'Test Page 2'
  private tag: string = 'Test Page 2'
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
        Button('push Page1')
          .margin(5)
          .onClick(() => router.pushUrl({ url: 'pages/TestPage1' }))
        Button('replace Page1')
          .margin(5)
          .onClick(() => router.replaceUrl({ url: 'pages/TestPage1' }))
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
    }
    .justifyContent(FlexAlign.Center)
    .height('100%')
  }
}