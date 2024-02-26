export enum TodoState {
  Todo,
  Doing,
  Finished
}
export class TodoModel {
  private static count:number = 0;
  id:number = 0;
  title:string = "";
  detail:string = "";
  state:TodoState = TodoState.Todo;

  constructor(title:string,detail:string = "") {
    this.id = TodoModel.count++;
    this.title = title;
    this.detail = detail;
    this.state = 0;
  }

  copy():TodoModel {
    let todo = new TodoModel(this.title,this.detail);
    todo.state = this.state;
    return todo;
  }
}