import { Header, Item } from '../common/components/CustomComponent'
// @Builder function ItemCard(item: Item) {
//   Row({ space: 10 }) {
//     Image(item.image).width(100)
//     Column({ space: 4 }) {
//       if (item.discount) {
//         Text(item.name).fontSize(20)
//           .fontWeight(FontWeight.Bold)
//         Text('原价¥ ' + item.price + '')
//           .fontColor('#CCC')
//           .fontSize(14)
//           .decoration({ type: TextDecorationType.LineThrough })
//         Text('折扣价¥ ' + item.discount + '')
//           .fontColor('#36D')
//           .fontSize(18)
//         Text('补贴¥ ' + (item.price - item.discount) + '')
//           .fontColor('#36D')
//           .fontSize(18)
//       } else {
//         Text(item.name).fontSize(20)
//           .fontWeight(FontWeight.Bold)
//         Text('¥ ' + item.price + '')
//           .fontColor('#36D')
//           .fontSize(18)
//       }
//
//     }
//     .height('100%')
//     .alignItems(HorizontalAlign.Start)
//   }
//   .width('100%')
//   .height(120)
//   .borderRadius(20)
//   .backgroundColor('#FFF')
//   .padding(10)
//   .margin({ bottom: 10 })
// }

@Builder export function ItemCard(item: Item) {
  Row({ space: 10 }) {
    Image(item.image).width(100)
    Column({ space: 4 }) {
      if (item.discount) {
        Text(item.name).fontSize(20)
          .fontWeight(FontWeight.Bold)
        Text('原价¥ ' + item.price + '')
          .fontColor('#CCC')
          .fontSize(14)
          .decoration({ type: TextDecorationType.LineThrough })
        Text('折扣价¥ ' + item.discount + '')
          .priceText()
        Text('补贴¥ ' + (item.price - item.discount) + '')
          .priceText()
      } else {
        Text(item.name).fontSize(20)
          .fontWeight(FontWeight.Bold)
        Text('¥ ' + item.price + '')
          .priceText()
      }

    }
    .height('100%')
    .alignItems(HorizontalAlign.Start)
  }
  .width('100%')
  .height(120)
  .borderRadius(20)
  .backgroundColor('#FFF')
  .padding(10)
  .margin({ bottom: 10 })
}

@Extend(Text) function priceText(){
  .fontColor('#F36')
  .fontSize(18)
}

@Entry
@Component
struct ListItems {
  private items = [
    {
      name: '华为Mate60',
      image: 'https://res.vmallres.com/pimages//uomcdn/CN/pms/202309/gbom/6942103107719/428_428_B60CE4EFDDD3AEBD2801A5E218B1EFFEmp.png',
      price: 6999,
      discount: 500
    },
    {
      name: '华为x50',
      image: 'https://res2.vmallres.com/pimages/uomcdn/CN/pms/202309/gbom/6942103107351/428_428_4204E42834E5E67AB0F1214F21D1570Emp.png',
      price: 8799
    },
    {
      name: '小米14',
      image: 'https://cdn.cnbj1.fds.api.mi-img.com/product-images/xiaomi14ghnegm/specs/3825.png',
      price: 4399
    },
    {
      name: 'OPPOFind12',
      image: 'https://img14.360buyimg.com/pop/jfs/t1/109727/10/24805/107521/62272049E441a5347/14de69bfa4343912.jpg',
      price: 3299
    },
    { name: '荣耀100', image: 'https://qna.smzdm.com/202311/23/655f4fab315a1986.jpg_e680.jpg', price: 3799 },
    { name: '荣耀100', image: 'https://qna.smzdm.com/202311/23/655f4fab315a1986.jpg_e680.jpg', price: 3799 },
  ]

  @Styles  fillScreen(){
  .width('100%')
  .height('100%')
  .backgroundColor('#EFEFEF')
  .padding(20)
}

  build() {
    Column() {
      Header().margin({ bottom: 30 })
      List({ space: 8 }) {
        ForEach(this.items, (item: Item) => {
          ListItem() {
            ItemCard(item)
          }
        })
      }.width('100%').height('100%').layoutWeight(1)

    }
    .fillScreen()
  }
}