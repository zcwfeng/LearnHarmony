import TaskModel from '../../model/TaskModel'
import TaskInfo from '../../viewmodel/TaskInfo'

@Component
export default struct TaskItem {
  @ObjectLink item: TaskInfo
  onTaskChange: () => void

  build() {
    Row() {
      if (this.item.finished) {
        Text(this.item.name)
          .finishedTask()
      } else {
        Text(this.item.name)
      }
      Checkbox()
        .select(this.item.finished)
        .onChange(val => {
          TaskModel.updateTaskStatus(this.item.id, val)
            .then(() => {
              this.item.finished = val
              this.onTaskChange()
            })
            .catch(error =>
            console.log('testTag',
              `更新任务失败，id=${this.item.id}`,
              JSON.stringify(error)))

        })
    }
    .card()
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Styles function card() {
  .width('95%')
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(15)
  .shadow({ radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4 })
}
//finish
@Extend(Text) function finishedTask() {
  .decoration({ type: TextDecorationType.LineThrough })
  .fontColor('#B1B2B1')
}
