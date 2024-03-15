import { Header } from '../common/components/CustomComponent'

@Entry
@Component
struct LifeCiclePage {
  @State show: boolean = false
  @State arr: string[] = []

  private tag: string = 'Life Cycle Page'
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
    Row() {
      Column({ space: 20 }) {
        Header({ title: '测试生命周期组件', hideRefresh: true })

        Button('切换显示')
          .onClick(() => this.show = !this.show)

        Row() {
          if (this.show) {
            MyText({ message: 'Hello World' })
          }
        }.height(30)

        Button('新增数据')
          .onClick(() => this.arr.push('usr_' + this.arr.length))
        ForEach(this.arr, (item, index) => {
          MyText({message:item,index:index,delete:this.delete.bind(this)})
        })
      }
      .width('100%')
    }
    .height('100%')
    .width('100%')
    .alignItems(VerticalAlign.Top)
    .justifyContent(FlexAlign.Start)
  }

  delete(index:number) {
    if(index > -1) {
      this.arr.splice(index,1)
    }
  }
}

@Component
struct MyText {
  message: string
  index?: number
  delete?: (index: number) => void
  private tag: string = 'MyText Page'
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
    Row({space:20}){
      Text(this.message)
        .fontSize(20)
        .margin(20)
      Blank()
      if(this.delete) {
        Image($r('app.media.delete'))
          .width(20)
          .margin(20)
          .onClick(()=>this.delete(this.index))
      }
    }
    .width('100%')
  }

}

