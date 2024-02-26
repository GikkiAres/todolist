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

import ToDoItem from '../view/ToDoItem';
import { getApp, localStorage } from '../viewmodel/app';
import { TodoModel, TodoState } from '../model/Todo';
import { NavigationBar } from '../components/NavigationBar';
import router from '@ohos.router';

@Entry
@Component
struct InsertPage {
  @LocalStorageLink("todo") todos: Array<TodoModel> = [];
  @State title: string = "";
  @State detail: string = "";

  aboutToAppear() {
    // this.totalTasks = DataModel.getData();
  }

  build() {
    Column() {
      NavigationBar({ title: "新增Todo" })
        .height(64);
      Column() {
        Text("Title")
          .margin({ top: 20 })
        TextInput({placeholder:"请输入标题",text:this.title})
          .onChange((value)=>{
            this.title = value;
          })
          .height(60)
          .margin({ top: 5 })
        Text("detail")
          .margin({ top: 20 })
        TextArea({placeholder:"请输入详情",text:this.detail})
          .onChange((value)=>{
            this.detail = value;
          })
          .height(100)
          .margin({ top: 5 })
        Button("确定")
          .margin({ top: 80 })
          .width(200)
          .onClick(() => {
            let todo = new TodoModel(this.title, this.detail);
            getApp().insertTodo(todo);
            router.back();
          })
          .backgroundColor("#2c6ccc")
      }
      .width(500)
    }.alignItems(HorizontalAlign.Center);
  }
}