import ShopInfo from '../viewmodel/ShopInfo'
import ShopItem from '../views/ShopItem'
import { Header } from '../common/components/CustomComponent'
import ShopModel from '../model/ShopModel'

@Entry
@Component
struct ShopPage {
  @State shops: ShopInfo[] = []
  isLoading:boolean = false
  isMore:boolean = true
  aboutToAppear() {
    this.loadShopInfo()
  }

  build() {
    Column({ space: 10 }) {
      Header({ title: '商铺列表' })
      List() {
        ForEach(this.shops, shop => {
          ListItem() {
            ShopItem({ shop: shop })
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .onReachEnd(()=>{
        console.log('触底了！！！');

        if(!this.isLoading && this.isMore) {
          this.isLoading = true
          // console.log('加载数据！！！');
          ShopModel.pageNo ++
          this.loadShopInfo()
        }
      })
    }
    .width('100%')
    .height('100%')
    .padding(10)
    .backgroundColor('#e1e2e3')
  }

  // 加载数据
  loadShopInfo() {

    // let shops = [
    //   {
    //     "id": 1,
    //     "name": "103茶餐厅",
    //     "images": [
    //       "/images/s3fqawWswzk.jpg",
    //       "/images/aZGOT1OjpJmLxG6urQ.jpg"
    //     ],
    //     "area": "大关",
    //     "address": "金华路锦昌文华苑29号",
    //     "avgPrice": 80,
    //     "comments": 3035,
    //     "score": 37,
    //     "openHours": "10:00-22:00"
    //   },
    //   {
    //     "id": 2,
    //     "name": "蔡馬洪涛烤肉·老北京铜锅涮羊肉",
    //     "images": [
    //       "/images/faca41195272.jpg",
    //       "/images/a9f88d706914.jpg",
    //       "/images/jpJmLxG6urQ.jpg"
    //     ],
    //     "area": "拱宸桥/上塘",
    //     "address": "上塘路1035号（中国工商银行旁）",
    //     "avgPrice": 85,
    //     "comments": 1460,
    //     "score": 46,
    //     "openHours": "11:30-03:00"
    //   }
    // ]
    //
    // shops.forEach(s => {
    //   s.images.forEach((src, i) => {
    //     s.images[i] = 'http://localhost:3000' + src
    //   })
    // })
    //
    // this.shops = shops

    ShopModel.getShopList()
      .then(shops => {
        shops.forEach(s => {
          s.images.forEach((src, i) => {
            s.images[i] = ShopModel.baseURL + src
          })
        })
        this.shops = this.shops.concat(shops)
        this.isLoading = false
        if(!shops || shops.length === 0) {
          this.isMore = false
        }
      })

  }
}