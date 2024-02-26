import router from '@ohos.router'

export class NavigationBarViewModel {
  static ShowBack:number = 0;
  static HideBack:number = 1;
}

@Component
export struct NavigationBar {
  backHandler:()=>void = ()=>{
    router.back();
  };
  @Prop title:string
  /**
   * hideback可能需要变化,设为prop?
   * 但是不想每次都要赋值.
   * 如果设置@State,如何父组件让子组件变化呢,又不能调用其方法,只能靠通知?
   */
  @State hidesBackButton?:boolean = false;
  _height:number = 64
  aboutToAppear() {
    // GaEventManager.registerEvent(NavigationBarViewModel.ShowBack,()=>{
    //   this.onShowBack();
    // });
    // GaEventManager.registerEvent(NavigationBarViewModel.HideBack,()=>{
    //   this.onHideBack()
    // });
  }
  aboutToDisappear(){
    // GaEventManager.unregisterEvent(NavigationBarViewModel.ShowBack);
    // GaEventManager.unregisterEvent(NavigationBarViewModel.HideBack);
  }

  onShowBack() {
    this.hidesBackButton = false;
  }
  onHideBack() {
    this.hidesBackButton = true;
  }

  build() {
    Row() {
      //---返回按钮---
        Button({ type: ButtonType.Normal }) {
          Image($r("app.media.svg_back")).size({ width: 30, height: 30 }).fillColor(Color.White)
        }
        .size({ width: 50, height: 50 })
        .onClick(() => {
          if(this.backHandler) {
            this.backHandler();
          }
          else {
            router.back();
          }
        })
        .width(100)
        .height('100%')
        .margin({ left: 20 })
        .backgroundColor(Color.Transparent).visibility(this.hidesBackButton?Visibility.Hidden:Visibility.Visible)

      //---标题---
      Text(this.title).fontSize(20).fontColor(Color.White)
      Blank().width(100)
    }.justifyContent(FlexAlign.SpaceBetween)
    .height(this._height).width('100%')
    .backgroundColor("#2c6ccc");
  }
}