import common from '@ohos.app.ability.common'
import Want from '@ohos.app.ability.Want'
import { Header } from '../common/components/CustomComponent'

@Entry
@Component
struct DocumentListPage {
  private index: number = 1
  @State docs: number[] = []
  private context = getContext(this) as common.UIAbilityContext
  build() {
    Row() {
      Column({ space: 10 }) {
        Header({ title: '文档列表' })
        Divider()
        Button('新建文档')
          .onClick(() => {
            this.docs.push(this.index)
            //1goto ability

            //2 want
            let want:Want = {
              deviceId:'',
              bundleName:'com.example.myapplication',
              moduleName:'entry',
              abilityName:'DocumentAbility',
              parameters:{
                instanceKey:`idx_${this.index++}`
              }
            }
            //3
            this.context.startAbility(want)
          })
        ForEach(this.docs,id=>{
          Row({space:20}){
            Image($r('app.media.icon'))
              .width(20)
            Text(`文档${id}`)
              .fontSize(20)
              .onClick(()=>{
                //1goto ability

                //2 want
                let want:Want = {
                  deviceId:'',
                  bundleName:'com.example.myapplication',
                  moduleName:'entry',
                  abilityName:'DocumentAbility',
                  parameters:{
                    instanceKey:'idx_' + id
                  }
                }
                //3
                this.context.startAbility(want)
              })
          }
          .margin({left:20})
          .width('100%')
        })
      }
      .width('100%')
    }
    .width('100%')
    .justifyContent(FlexAlign.Start)
  }
}