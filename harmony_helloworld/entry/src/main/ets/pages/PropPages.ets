import { Header } from '../common/components/CustomComponent'
@Observed
class Task {
  static id: number = 1
  name: string = `任务 ${Task.id++}`
  finished: boolean = false
}

class StatInfo {
  totalTask: number = 0
  finishTask: number = 0
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

@Entry
@Component
struct PropPages {
  // @State totalTask: number = 0
  // @State finishTask: number = 0
  // @State stat: StatInfo = new StatInfo()
  @Provide stat: StatInfo = new StatInfo()

  build() {
    Column({ space: 10 }) {
      // TaskStatistics({ finishTask: this.finishTask, totalTask: this.totalTask })
      // TaskList({ finishTask: $finishTask, totalTask: $totalTask })
      // TaskStatistics({ finishTask: this.stat.finishTask, totalTask: this.stat.totalTask })
      // TaskList({stat:$stat})
      Header()
      TaskStatistics()
      TaskList()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F2F3')
  }
}



///可单独份文件，为了方便学习
@Component
struct TaskStatistics {
  // @Prop finishTask: number
  // @Prop totalTask: number
  @Consume stat: StatInfo

  build() {
    Column(){
      Row() {
        Text('任务进度')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
        Stack() {
          Progress({ value: this.stat.finishTask,
            total: this.stat.totalTask,
            type: ProgressType.Ring })
          Row() {
            Text(this.stat.finishTask.toString())
              .fontSize(24)
            Text(' / ' + this.stat.totalTask.toString())
              .fontSize(24)
          }
        }
      }
      .card()
      .margin({ top: 20, bottom: 10 })
      .justifyContent(FlexAlign.SpaceEvenly)
    }

  }
}

@Component
struct TaskList {
  @State tasks: Task[] = []
  // @Link totalTask: number
  // @Link finishTask: number
  // @Link stat: StatInfo
  @Consume stat: StatInfo

  handleTaskChange() {
    this.stat.totalTask = this.tasks.length
    this.stat.finishTask = this.tasks.filter(item => {
      item.finished
      console.log('testTag',`${item.name}`)
    }).length

  }

  build() {
    Column() {
      Button('新增任务')
        .width(200)
        .onClick(() => {
          this.tasks.push(new Task())
          this.handleTaskChange()
        })
      List({ space: 10 }) {
        ForEach(this.tasks, (item: Task, index) => {
          ListItem() {
            TaskItem({item:item,onTaskChange:this.handleTaskChange.bind(this)})
          }
          .swipeAction({ end: this.DeleteButton(index) })
        })

      }
      .width('100%')
      .layoutWeight(1)
      // .alignListItem(ListItemAlign.Center)
      .backgroundColor('#F1F2F3')
    }
  }

  @Builder DeleteButton(index: number) {
    Button() {
      Image($r("app.media.delete"))
        .colorFilter(Color.White)
        .width(20)
    }
    .width(40)
    .height(40)
    .type(ButtonType.Circle)
    .backgroundColor(Color.Red)
    .margin(5)
    .onClick(() => {
      this.tasks.splice(index, 1)
      this.handleTaskChange()
    })
  }
}

@Component
struct TaskItem {
  @ObjectLink item:Task
  onTaskChange:()=> void
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
          this.item.finished = val
          this.onTaskChange()
        })
    }
    .card()
    .justifyContent(FlexAlign.SpaceBetween)
  }
}
