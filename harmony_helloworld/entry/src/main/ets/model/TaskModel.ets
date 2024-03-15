import relationalStore from '@ohos.data.relationalStore';
import TaskInfo from '../viewmodel/TaskInfo';

class TaskModel {
  private rdbStore: relationalStore.RdbStore
  private tableName: string = 'TASK'

  initTaskDB(context) {
    //1.rdb config
    const config = {
      name: 'MyApplication.db',
      securityLevel: relationalStore.SecurityLevel.S1
    }
    //2. init sql
    const sql = `CREATE TABLE IF NOT EXISTS TASK(
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    NAME TEXT NOT NULL,
    FINISHED bit
    )`
    //3. get rdb
    relationalStore.getRdbStore(context, config, (err, rdbStore) => {
      if (err) {
        console.log('testTag', 'get rdb store failed!')
        return
      }
      rdbStore.executeSql(sql)
      console.log('testTag', '创建task表成功')
      this.rdbStore = rdbStore
    })
  }

  async getTaskList() {
    //1.构建查询条件
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    //2.查询
    let result = await this.rdbStore.query(predicates, ['ID', 'NAME', 'FINISHED'])
    //3.查询结果
    //3.1 定义数组组装最终的查询结果
    let tasks: TaskInfo[] = []
    //3.2遍历封装
    while (!result.isAtLastRow) {
      //3.3指针移动到下一行
      result.goToNextRow()
      //3.4获取数据
      let id = result.getLong(result.getColumnIndex('ID'))
      let name = result.getString(result.getColumnIndex('NAME'))
      let finished = result.getLong(result.getColumnIndex('FINISHED'))
      //3.5封装到数组
      tasks.push({ id, name, finished: !!finished }) //!!finished number-》boolean
    }
    console.log('testTag', '查询到数据', JSON.stringify(tasks))
    return tasks
  }

  addTask(name: string):Promise<number> {
    return this.rdbStore.insert(this.tableName, { name, finished: false })
      // .then(id=>{
      //
      // })
  }

  updateTaskStatus(id: number, finished: boolean) {
    //1.update data
    let data = {finished}
    //2.update 条件
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo('ID',id)
    return this.rdbStore.update(data,predicates)
  }

  deleteTaskById(id: number) {
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo('ID',id)
    return this.rdbStore.delete(predicates)
  }
}

let taskModel = new TaskModel()

export default taskModel as TaskModel