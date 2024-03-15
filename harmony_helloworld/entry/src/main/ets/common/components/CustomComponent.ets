import router from '@ohos.router'
@Component
export struct Header {
  private title: ResourceStr = '商品列表'
  private hideLeft: boolean = false
  private hideRefresh:boolean = false
  @State params:any = router.getParams()
  build() {
    Row() {
      if(!this.hideLeft){
        Image($r('app.media.back'))
          .width(30)
          .onClick(()=>{
            // router.showAlertBeforeBackPage({
            //   message:'确定返回吗？'
            // })
            router.back()
          })
      }
      if(this.params && this.title) {
        Text(this.params.id + "." + this.title)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
      }

      Blank()
      if(!this.hideRefresh){
        Image($r('app.media.refresh'))
          .width(30)
      }
    }
    .width('100%')
    .height(30)
  }
}

export class Item {
  name: string
  image: ResourceStr
  price: number
  discount: number

  constructor(name: string, image: ResourceStr, price: number, discount: 0) {
    this.name = name
    this.image = image
    this.price = price
    this.discount = discount
  }
}


