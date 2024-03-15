import common from '@ohos.app.ability.common'
import Want from '@ohos.app.ability.Want'

@Entry
@Component
struct DocumentPage {
  private context = getContext(this) as common.UIAbilityContext
  @State editTtitle: boolean = false
  @State title: string = '标题'
  @State content: string = ''

  build() {
    Row() {
      Column({ space: 10 }) {
        Row({ space: 10 }) {
          Image($r('app.media.back'))
            .width(30)
            .onClick(() => {
              let want:Want = {
                deviceId:'',
                bundleName:'com.example.myapplication',
                moduleName:'entry',
                abilityName:'EntryAbility'
              }
              //3
              this.context.startAbility(want)
            })

          if (!this.editTtitle) {
            Text(this.title)
              .fontSize(30)
              .fontWeight(FontWeight.Bold)

          }


        }
        .width('100%')
        .justifyContent(FlexAlign.Start)

        Divider()
        TextInput({ placeholder: '请输入内容' })

      }
      .width('100%')
      .height('100%')
    }
  }
}