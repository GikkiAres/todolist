import { TodoModel, TodoState } from '../model/Todo';

let appData:Record<string,Array<TodoModel>|TodoState> = {
  'todos':[],
  'stateFilter':TodoState.Todo,
};
export let localStorage: LocalStorage = new LocalStorage(appData);

let app:App|null = null;
export function getApp() {
  if(!app) {
    app = new App();
  }
  return app;
}

export class App {
   getAllTodo(): TodoModel[] {
    let todoLink: SubscribedAbstractProperty<Array<TodoModel>> = localStorage.link<Array<TodoModel>>('todos')
    return todoLink.get();
  }
  deleteTodo(id:number) {
    let todoLink: SubscribedAbstractProperty<Array<TodoModel>> = localStorage.link<Array<TodoModel>>('todos')
    let todos = todoLink.get();
    let index = todos.findIndex((item)=>(item.id == id));
    if(index != -1) {
      todos.splice(index,1);
    }
  }

  insertTodo(todo:TodoModel) {
    let todoLink: SubscribedAbstractProperty<Array<TodoModel>> = localStorage.link<Array<TodoModel>>('todos')
    let todos = todoLink.get();
    todos.push(todo);
  }
  //
  // insertTodo2(todo:TodoModel) {
  //   //prop得到的数组不能双向绑定,修改prop的数据,不会触发ui更新,Storagee内部的数据源没有改变
  //   let todoLink: SubscribedAbstractProperty<Array<TodoModel>> = localStorage.link<Array<TodoModel>>('todos')
  //   let todos = todoLink.get();
  //   let index = -1;
  //   //找到合适的位置.
  //   if(todo.state == TodoState.Todo) {
  //     //Todo类型需要插入到Finish前面的最后一个.
  //     let targetIndex = todos.findIndex((item)=>{
  //       return item.state == TodoState.Finished;
  //     })
  //     if(targetIndex == -1) index = todos.length;
  //     else index = targetIndex;
  //   }
  //   else if(todo.state == TodoState.Doing) {
  //     //Doing类型,插到Todo前面最后一个,没有则Finish前面最后一个.
  //     let targetIndex = todos.findIndex((item)=>{
  //       return item.state == TodoState.Todo;
  //     })
  //     if(targetIndex == -1) {
  //       targetIndex = todos.findIndex((item)=>{
  //         return item.state == TodoState.Finished;
  //       })
  //     }
  //     if(targetIndex == -1) index = todos.length;
  //     else index = targetIndex;
  //   }
  //   else {
  //     //finished  直接插入到最后.
  //     index = todos.length;
  //   }
  //   //在index位置插入数据,如果当前位置有数据,当前数据将会放到插入数据的后面.
  //   todos.splice(index,0,todo);
  // }

  updateTodo(todo:TodoModel,id:number) {
    let todoLink: SubscribedAbstractProperty<Array<TodoModel>> = localStorage.link<Array<TodoModel>>('todos')
    let todos = todoLink.get();
    let index = todos.findIndex((item)=>(item.id == id));
    if(index != -1) {
      todos[index] = todo;
    }
  }
  // getTodo(index:number):TodoModel {
  //   let todoPop: SubscribedAbstractProperty<Array<TodoModel>> = localStorage.link<Array<TodoModel>>('todos')
  //   return todoPop.get()[index];
  // }
  getTodo(id:number):TodoModel {
      let todoPop: SubscribedAbstractProperty<Array<TodoModel>> = localStorage.link<Array<TodoModel>>('todos')
      return todoPop.get().find((item)=>(item.id == id));
  }
}

