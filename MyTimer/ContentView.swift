//
//  ContentView.swift
//  MyTimer
//
//  Created by 持田晴生 on 2023/04/25.
//

import SwiftUI

struct ContentView: View {
    //タイマーの変数を作成
    @State var timerHandler : Timer?
    //カウント（経過時間）の変数を作成
    @State var count = 0
    //永続化する秒数設定（初期値は10）
    @AppStorage("timer_value")var timerValue = 10
    //アラート表示有無
    @State var showAlert = false
    
    var body: some View {
        NavigationStack{
            //奥から手前方向にレイアウト
            
            ZStack{
                //背景画像
                Image("backgroundTimer")
                //リサイズする
                    .resizable()
                //セーフエリアを超えて画面全体に配置します
                    .ignoresSafeArea()
                //アスペクト比（縦鉾日）を維持して短編基準に収まるようにする
                    .scaledToFill()
                //View(部品)間の感覚を３０にする
                VStack(spacing: 30.0){
                    //テキストを表示する
                    Text("残り\(timerValue - count)秒")
                    //文字のサイズを指定
                        .font(.largeTitle)
                    //水平にレイアウト(横方向にレイアウト)
                    HStack{
                        //スタートボタン
                        Button{
                            //ボタンをタップしたときのアクション
                            //タイマーをカウントダウン開始する関数を呼び出す
                            startTimer()
                        }label: {
                            Text("スタート")
                            //文字サイズを指定
                                .font(.title)
                            //文字色を白に指定
                                .foregroundColor(Color.white)
                            //幅高さを140に指定
                                .frame(width: 140,height: 140)
                            //背景を指定
                                .background(Color("startColor"))
                            //円形にくり抜く
                                .clipShape(Circle())
                            
                        }//スタートボタンはここまで
                        
                        //ストップボタン
                        Button{
                            //ボタンをタプしたときのアクション
                            //timerHandlerをアンラップしてunwrapedTimerHandlerに代入
                            if let unwrapedTimerHandler = timerHandler{
                                //もしタイマーが実行中だったら停止
                                if unwrapedTimerHandler.isValid == true{
                                    //タイマー停止
                                    unwrapedTimerHandler.invalidate()
                                }
                            }
                        }label: {
                            Text("ストップ")
                            //文字サイズを指定
                                .font(.title)
                            //文字色を白に指定
                                .foregroundColor(Color.white)
                            //幅高さを１４０に指定
                                .frame(width: 140,height: 140)
                            //背景を指定
                                .background(Color("stopColor"))
                            //円形にくり抜く
                                .clipShape(Circle())
                        }//ストップボタンここまで
                        
                    }//HStackここまで
                }//VStackここまで
            }//ZStackここまで
            //画面が表示されるときに実行される
            .onAppear{
                //カウント（経過時間）の変数を初期化
                count = 0
            }// .onAppearここまで
            
            //ナビゲーションにボタンを追加
            .toolbar {
                //ナビゲーションバーの右にボタンを追加
                ToolbarItem(placement: .navigationBarTrailing){
                    //ナビゲーション繊維{
                    NavigationLink{
                        SettingView()
                    }label: {
                        //テキストを表示
                        Text("秒数設定")
                    }//NavigationLink ここまで
                }//ToolbarItemここまで
            }//.toolbar ここまで
            
            //状態変数showA;ertがTrueになったときに実行される
            .alert("終了",isPresented: $showAlert){
                Button("OK"){
                    //OKをタップしたときにここが実行される
                    print("OKをタップされました")
                }
            }message: {
                Text("タイマー終了時間です")
            }//.alertここまで
        }//NavigationStack　ここまで
    }//body ここまで
    
    //１行ごとに実行されてカウントダウンする
    func countDownTimer(){
        
        //count(経過時間)に＋１していく
        count += 1
        
        //残り時間が０以下のとき、タイマーを止める
        if timerValue - count <= 0{
            //タイマー停止
            timerHandler?.invalidate()
            
            //アラートを表示する
            showAlert = true
        }
    }//countDownTimer()ここまで
    
    //タイマーをカウントダウン開始する関数
    func startTimer(){
        //timerHandlerをアンラップしてunwrapedTimerHandlerに代入
        if let unwarapedTimerHandler = timerHandler{
            //もしタイマーが、実行中だったらスタートしない
            if unwarapedTimerHandler.isValid == true{
                //何も処理しない
                return
            }
        }
        
        //残り時間が０以下のとき、count(経過時間)を０に初期化する
        if timerValue - count <= 0{
            //count(経過時間を0に初期化する
            count = 0
        }
        
        //タイマーをスタート
        timerHandler = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ _ in
            //タイマー実行時に呼び出される
            //１秒毎に実行されてカウントダウンする関数を実行する
            countDownTimer()
        }
    }//startTimerここまで
    
}// ContentView　ここまで

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
