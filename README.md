### ER図
[![Image from Gyazo](https://i.gyazo.com/5a4434e024ef4bfb768b76885cdee7a1.png)](https://gyazo.com/5a4434e024ef4bfb768b76885cdee7a1)

### 画面遷移図   
https://www.figma.com/design/aseiWjjooNL4DW6ZvSHE6w/Untitled?node-id=0-1&node-type=canvas&t=snL1TiijAfhatKjs-0     

■ サービス概要  
このサービスは、ユーザーが性格診断を受けることで、鎌倉時代の仏教僧やその歴史との関連性を見出し、学びを深めることを目的とした診断ツールです。
診断結果をもとに、ユーザーに最も適した仏教僧を提案し、興味関心が薄いユーザーでも、その歴史に触れることができます。自分にぴったりの仏教僧が
どの人物かを知り、その人物に関する教えや時代背景を学ぶことができます。
また、実際に寺院に訪問し、その体験を記録共有するポスト機能を通じて、ユーザーがアクティブに歴史や仏教に関わる切っ掛けを提供します。

■ このサービスへの思い・作りたい理由  
私は史学科の卒業論文で「鎌倉時代の延暦寺強訴」を研究しました。その研究を通じて、鎌倉時代の仏教が非常に複雑であり学術的に理解することが難しい
と感じました。そこで、もっと多くの人に鎌倉時代の仏教を知ってもらうための方法を考えました。

このサービスを作ろうと思った理由は、鎌倉時代の仏教に親しみをもってもらうため、その難解さを解消したいという思いからです。性格診断をとりいれた
ツールを提供することで、日本史を学ぶ中高生や一般の人々が楽しく学べて、鎌倉時代の仏教を身近に感じてもらうことを目標にしています。

■ ユーザー層について  
- 年齢層：１０代～２０代の若年層
- 性別：男女問わず
- 利用デバイス：スマートフォンが中心
- 関心の傾向：仏教や歴史に関心が薄い

ターゲット層は、中高生の学習者と仏教、歴史に関心の薄い一般の人々です。特に１０代、２０代は学校教育で歴史に触れる機会もあるが興味を持つきっかけ
をつかめない人も多いと感じています。スマホで利用可能な診断ツールなら、日常的に利用しやすく、関心が薄い層にもアプローチできると考えています。
また、「自分に似た僧侶を診断する」というコンセプトが心理的な敷居をさげ、興味関心を持つきっかけを提案することを目標としています。

■ サービスの利用イメージ
1. ユーザーはアプリまたはウェブサイトにアクセスし、簡単な性格診断を受けます。
2. 診断後、結果として自分に適した鎌倉時代の仏教僧を提示（著名な仏教僧の中から選出）
3. ユーザーは診断結果受け、仏教や歴史に対する興味関心を持つことができます。
4. ユーザーはログイン登録を行うことで、訪れた寺院の写真、コメントを登録できるようになります。

■ ユーザーの獲得について  
SNSでのコンテンツ発信や、友人の学校教員に学生への利用を依頼することを検討

■ サービスの差別化ポイント・推しポイント  
仏教に関心が薄い層に対し、性格診断を通じて親しみを持たせることはユニークな方法であると考えています。敷居が高いと感じる人々に対し、ゲーム感覚で楽し
めるため、アクセスしやすい点が差別化要素です。

■ 機能候補  
MVPリリース
- 性格診断機能: 質問に基づいてユーザーの性格を評価し、最適な仏教僧を提案する機能。
  
本リリース
- ログイン機能。
- ログイン後、ユーザーが訪れた寺院の写真とコメントを投稿するポスト機能を追加。ユーザー体験の共有を可能にします。
- 上記に加え、ユーザーが診断結果をSNSでシェアできる機能を追加。

■ 機能の実装方針予定
- Ruby on Rails を使用。
- 質問や選択肢は ActiveHash を利用し、診断結果に応じた仏教僧を提案するロジックを実装。
- ログイン機能を追加し、認証には Devise を使用予定。

■ 診断フローの設計  
診断結果の基本的な流れは、ユーザーが一連の質問を答え、それに基づいて結果が出る形になります。具体的には以下のように考えています。
1. スタート画面
  - アプリの紹介や開始ボタンを表示
  - 診断ボタンを押すと、次の画面に遷移します。
2. 質問画面
  - 複数の質問を用意
  - 各質問には選択肢があり、ユーザーはそれに答えます。
3. 結果の表示
  - 診断結果を表示。ユーザーに性格タイプから関連する仏教僧を表示します。

■ 診断ロジックの設計  
診断に関しては具体的に以下のように考えております。
1. 質問ごとにスコアを設定。
  - 各質問において値を設定する。
2. スコアを計算。
  - Modelにおいて各質問の値にスコアを付け、それを加算するメソッドを作成。
3. ActiveHashによる照合。
  - 送られたスコアの合計と照合するために、ActiveHashを使用します。
  - スコアの範囲を定義した配列と照合します。

■ ポスト機能利用のながれ  
1. ログイン
  - ユーザーは新規登録、ログインを行います。
2. 投稿ページへ移動
  - ナビゲーションバーから「新規投稿」ボタンを選択します。
3. 投稿内容の入力
  - 以下の内容を入力します。
    - 寺院名
    - 場所
    - 写真のアップロード
    - コメント
4. 投稿の表示
  - 投稿は他のユーザーとの投稿共有ページに標示されます。
