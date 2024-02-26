/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import CommonConstants from '../common/constant/CommonConstant';
import ToDoItem from '../view/ToDoItem';
import { getApp, localStorage } from '../viewmodel/app';
import { TodoModel, TodoState } from '../model/Todo';
import router from '@ohos.router';

@Entry(localStorage)
@Component
struct ToDoListPage {
  // @LocalStorageLink("todos") todos: Array<TodoModel> = [];
  @LocalStorageProp("filterState") filterState:TodoState = TodoState.Todo;
  @State filteredTodos:TodoModel[] = [];
  aboutToAppear() {
    // this.totalTasks = DataModel.getData();
  }

  onPageShow(): void {
    this.updateList();
  }

  /**
   * 左滑菜单
   * @param $$
   * @param index
   */
  @Builder
  SwipeMenu(todo: TodoModel, index: number) {
    Column() {
      Row() {
        // Finish
        if(todo.state == TodoState.Todo) {
          Button({ type: ButtonType.Normal }) {
            Image($r("app.media.svg_start"))
              .width(30)
              .height(30)
              .fillColor(Color.White)
          }
          .width(60)
          .height("100%")
          .backgroundColor("#F7CE00")
          .borderRadius({ topLeft: 8, bottomLeft: 8 })
          .onClick(() => {
            this.updateState(index, TodoState.Doing);
          })
        }
        else if(todo.state == TodoState.Doing) {
          Button({ type: ButtonType.Normal }) {
            Image($r("app.media.svg_finished"))
              .width(30)
              .height(30)
              .fillColor(Color.White)
          }
          .width(60)
          .height("100%")
          .backgroundColor("#2c6ccc")
          .borderRadius({ topLeft: 8, bottomLeft: 8 })
          .onClick(() => {
            this.updateState(index, TodoState.Finished);
          })
        }

        Button({ type: ButtonType.Normal }) {
          Image($r("app.media.svg_mail_trash"))
            .width(30)
            .height(30)
        }
        .backgroundColor("#FF723B")
        .borderRadius({ topRight: 8, bottomRight: 8 })
        .width(60)
        .height("100%")
        .onClick(() => {
          this.delete(todo.id);
        })
      }.height("100%")
    }
    .height("100%")
    .justifyContent(FlexAlign.Start)
    .margin({ right: 14 })
  }

  build() {
    Stack() {
      Column({ space: CommonConstants.COLUMN_SPACE }) {
        Row() {
          Button("Todo",{ type: ButtonType.Normal })
            .goupStyle(this.filterState == TodoState.Todo)
            .onClick(()=>{this.changeFilterState(TodoState.Todo)})
          Button("Doing",{ type: ButtonType.Normal })
            .goupStyle(this.filterState == TodoState.Doing)
            .onClick(()=>{this.changeFilterState(TodoState.Doing)})
          Button("Done",{ type: ButtonType.Normal })
            .goupStyle(this.filterState == TodoState.Finished)
            .onClick(()=>{this.changeFilterState(TodoState.Finished)})
        }
        .width(500)
        .margin({top:30})
        .justifyContent(FlexAlign.SpaceBetween)


        List() {
          ForEach(this.filteredTodos, (item: TodoModel, index: number) => {
            ListItem() {
              ToDoItem({ todo: item })
            }.margin({ top: 5 })
            .swipeAction({ end: { builder: () => {
              this.SwipeMenu(item, index)
            } } })
            .onClick(() => {
              let params: Record<string, number> = { "id": item.id };
              router.pushUrl({ url: "pages/DetailPage", params })
            })
          }
            // , (item: TodoModel) => JSON.stringify(item.title + item.id)
          )}
      }
      .width(CommonConstants.FULL_LENGTH)
      .height(CommonConstants.FULL_LENGTH)
      .backgroundColor($r('app.color.page_background'))
      .padding({ left: 20, right: 20 })

      Button("Add").onClick(() => {
        router.pushUrl({ url: "pages/InsertPage" })
      }).offset({ x: -100, y: -100 })
    }.align(Alignment.BottomEnd);
  }

  delete(index: number) {
    //ui中删除
    // this.todos.splice(index,1);
    //vm中删除.
    getApp().deleteTodo(index);
    this.updateList();
  }

  updateState(index: number, state: TodoState) {
    let todo = this.filteredTodos[index];
    todo.state = state;
    this.updateList();
  }
  updateList() {
    let todos = getApp().getAllTodo();
    this.filteredTodos = todos.filter((item)=>(item.state == this.filterState));
  }

  changeFilterState(state:TodoState) {
    if(this.filterState == state){
      return;
    }
    this.filterState = state;
    this.updateList();
  }


}

// 内容文本
@Extend(Button)
function goupStyle(isSelected:boolean) {
  .fontSize(16)
  .fontWeight(400)
  .width(150)
  .height(50)
  .backgroundColor(isSelected?"#2c6ccc":Color.White)
  .borderColor(isSelected?Color.Transparent:Color.Gray)
  .fontColor(isSelected?Color.White:Color.Black)
  .borderRadius(5)
}