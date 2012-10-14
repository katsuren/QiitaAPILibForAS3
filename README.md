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
      // リクエストに成功した場合はここで処理を行う
      var data:AuthData = event.data as AuthData;
      trace("auth complete!");
      trace("token :", data.token);
      trace("raw response :", data.response);
    }
    
    public function authFailedHandler(event:APIErrorEvent):void
    {
      // なにかエラーが発生したらここで処理を行う
      trace("auth failed.");
      trace("reason :", event.text);
    }


下記はユーザーの投稿を取得し、取得したすべての記事をストックする例です。  
※デフォルトでは20件しか取得しないので、1000件投稿しているユーザーの場合はページャーをいじる必要があります

    public var qiita:Qiita;
    public var token:String = "some_dummy_token";
    
    public function init():void
    {
        qiita = new Qiita();
        
        // ユーザーの投稿取得用
        qiita.addEventListener(APIEvent.GET_USER_ITEM_LIST_COMPLETE, getUserItemListCompleteHandler);
        qiita.addEventListener(APIErrorEvent.GET_USER_ITEM_LIST_FALIED, getUserItemListFailedHandler);
        
        // ストックの確認用
        qiita.addEventListener(APIEvent.STOCK_COMPLETE, stockCompleteHandler);
        qiita.addEventListener(APIEvent.STOCK_FAILED, stockFailedHandler);
    }
    
    public function getUserItemList(uid:String="katsuren"):void
    {
        // この場合は新着から100件の記事を取得します.
        // 100件以上の記事がある場合は、一度の取得上限が100件のため、
        // オフセットを指定して取得する必要があります.
        // 例えば、右のようにします qiita.getUserItemList(uid, token, 100, 3);
        qiita.getUserItemList(uid, token, 100);
    }
    
    public function stock(uuid:String):void
    {
        qiita.stock(uuid, token);
    }
    
    public function getUserItemListCompleteHandler(e:APIEvent):void
    {
        var list:Vector.<ItemData> = e.data as Vector.<ItemData>;
        for (var i:int=0; i<list.length; i++) {
            var item:ItemData = list[i];
            stock(item.uuid);
        }
    }
    
    public function getUserItemListFailedHandler(e:APIErrorEvent):void
    {
        trace("getUserItemList failed!");
        trace("Error :", e.text);
    }
    
    public function stockCompleteHandler(e:APIEvent):void
    {
        trace("stock complete");
    }
    
    public function stockFailedHandler(e:APIErrorEvent):void
    {
        trace("stock failed");
        trace("Error :", e.text);
    }
