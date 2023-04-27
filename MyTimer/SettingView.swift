//
//  SettingView.swift
//  MyTimer
//
//  Created by 持田晴生 on 2023/04/25.
//

import SwiftUI

struct SettingView: View {
    //永続化する秒数設定（初期値は１０）
    @AppStorage("timer_value") var timerValue = 10
    
    //秒数設定
    @State var timeValue = 10
    var body: some View {
        //奥から手前方向にレイアウト
        ZStack{
            //背景色表示
            Color("backgroundSetting")
            //セーフエリアを超えて画面全体に配置します
                .ignoresSafeArea()
            
            //垂直にレイアウト
            VStack{
                //スペースを空ける
                Spacer()
                //テキストを表示する
                Text("\(timeValue)秒")
                //文字サイズを指定
                    .font(.largeTitle)
                //スペースを空ける
                Spacer()
                //Pickeを表示
                Picker(selection: $timeValue){
                    Text("10")
                        .tag(10)
                    Text("20")
                        .tag(20)
                    Text("30")
                        .tag(30)
                    Text("40")
                        .tag(40)
                    Text("50")
                        .tag(50)
                    Text("60")
                        .tag(60)
                }label: {
                    Text("選択")
                }
                //Pikerをホイール表示
                .pickerStyle(.wheel)
                //スペースを空ける
                Spacer()
            }//Vstakここまで
        }//ZStackここまで
    }//bodyここまで
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
