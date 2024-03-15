import TaskModel from '../../model/TaskModel'
import TaskInfo from '../../viewmodel/TaskInfo'
import TaskItem from './TaskItem'

@Component
export default struct TaskList {
  @State tasks: TaskInfo[] = []
  @Link totalTask: number
  @Link finishTask: number
  // @Link stat: StatInfo
  // @Consume stat: StatInfo
  idx: number = 1

  handleTaskChange() {
    this.totalTask = this.tasks.length
    this.finishTask = this.tasks.filter(item => item.finished).length

  }

  // 任务信息弹窗
  dialogController: CustomDialogController = new CustomDialogController({
    builder: TaskInfoDialog({ onTaskConfirm: this.handleAddTask.bind(this) }),
  })

  aboutToAppear() {
    console.log('testTag', '初始化组件，查询任务列表')
    TaskModel.getTaskList()
      .then(tasks => {
        this.tasks = tasks
        this.handleTaskChange()
      })
  }

  handleAddTask(name: string) {
    //1.新增任务
    TaskModel.addTask(name)
      .then(id => {
        console.log('testTag', '处理新增任务' , name)
        //回显数组页面
        this.tasks.push(new TaskInfo(id, name))
        this.handleTaskChange()
        this.dialogController.close()
      })
      .catch(error => console.log('testTag', `新增任务失败${error}`, name))


  }

  build() {
    Column() {
      Button('新增任务')
        .width(200)
        .onClick(() => {
          // 打开新增表单对话框
          this.dialogController.open()
        })
      List({ space: 10 }) {
        ForEach(this.tasks, (item: TaskInfo, index) => {
          ListItem() {
            TaskItem({ item: item, onTaskChange: this.handleTaskChange.bind(this) })
          }
          .swipeAction({ end: this.DeleteButton(index,item.id) })
        })

      }
      .width('100%')
      .layoutWeight(1)
      // .alignListItem(ListItemAlign.Center)
      .backgroundColor('#F1F2F3')
    }
  }

  @Builder DeleteButton(index: number,id:number) {
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
      // 删除任务
      TaskModel.deleteTaskById(id)
        .then(() => {
          this.tasks.splice(index, 1)
          console.log('testTag', `尝试删除任务，index: ${index}`)
        })
        .catch(error => console.log('testTag', '删除任务失败，id = ', id, JSON.stringify(error)))


    })
  }
}

@CustomDialog
struct TaskInfoDialog {
  name: string = ''
  onTaskConfirm: (name: string) => void
  controller: CustomDialogController

  build() {
    Column({ space: 20 }) {
      TextInput({ placeholder: '输入任务名' })
        .onChange(val => this.name = val)
      Row() {
        Button('确定')
          .onClick(() => {
            this.onTaskConfirm(this.name)
          })
        Button('取消')
          .backgroundColor(Color.Grey)
          .onClick(() => {
            this.controller.close()
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .padding(20)
  }
}