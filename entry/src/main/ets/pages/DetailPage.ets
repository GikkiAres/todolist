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
import { NavigationBar } from '../components/NavigationBar';
import router from '@ohos.router';

@Entry
@Component
struct DetailPage {
  @State title: string = "";
  @State detail: string = "";
  // todoId:number|null = null;
  todo:TodoModel|null = null;
  aboutToAppear() {
    let params:Record<string,number> = router.getParams() as Record<string,number>;
    let id = params["id"];
    let todo = getApp().getTodo(id);
    this.todo = todo;
    this.title = todo.title;
    this.detail = todo.detail;
  }

  build() {
    Column() {
      NavigationBar({ title: "修改Todo" })
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
            // let todo = new TodoModel(this.title, this.detail);
            this.todo!.title = this.title;
            this.todo!.detail = this.detail;
            getApp().updateTodo(this.todo!,this.todo!.id);
            router.back();
          })
          .backgroundColor("#2c6ccc")
      }
      .width(500)
    }.alignItems(HorizontalAlign.Center);
  }
}