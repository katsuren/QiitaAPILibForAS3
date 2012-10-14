QiitaAPILibForAS3
======================
Qiita API を AS3 で利用するためのライブラリです。  
Qiita API については下記を御覧ください。  
[Qiita API document](http://qiita.com/docs "Qiita API document")  
Flash だけでなく AIR でも利用できるので、iOS/Android アプリ開発にも利用できます。  

対応API
-------
2012/10/12 時点で、下記のAPIに対応しています。  
+ 残りリクエスト可能数とRate Limit取得
+ token取得
+ 特定ユーザーの情報取得
+ 特定ユーザーの投稿取得
+ 特定ユーザーのストックした投稿取得
+ 特定ユーザーのフォローしているユーザー取得
+ 特定ユーザーのフォローしているタグ取得
+ 特定タグの投稿取得
+ タグ一覧取得
+ 検索結果取得
+ 新着投稿の取得
+ 自分のストックした投稿の取得
+ 投稿の実行
+ 投稿の更新
+ 投稿の削除
+ 特定の投稿取得
+ 投稿のストック
+ 投稿のストック解除

ライセンス
----------
Copyright &copy; 2012 Takefumi Katsuren  
Distributed under the [MIT License][mit].  
[MIT]: http://www.opensource.org/licenses/mit-license.php  

使い方
------
Qiita クラスは各APIをリクエストすると
対応した APIEvent(成功時) または APIErrorEvent() を発行します。
それぞれの Event に必要なデータが格納されているので、
そのデータを利用します。  

下記は認証の例です。パラメタの詳細などは各メソッドのコメントを参照ください。  

    public var qiita:Qiita;
    
    public function init():void
    {
      qiita = new Qiita();
      qiita.addEventListener(APIEvent.AUTH_COMPLETE, authCompleteHandler);
      qiita.addEventListener(APIErrorEvent.AUTH_FAILED, authFailedHandler);
    }
    
    public function auth(uid:String, pwd:String):void
    {
      trace("auth start");
      qiita.auth(uid, pwd);
    }
    
    public function authCompleteHandler(event:APIEvent):void
    {
      var data:AuthData = event.data as AuthData;
      trace("auth complete!");
      trace("token :", data.token);
      trace("raw response :", data.response);
    }
    
    public function authFailedHandler(event:APIErrorEvent):void
    {
      trace("auth failed.");
      trace("reason :", event.data.error);
    }
