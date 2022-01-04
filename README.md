# LOOK

## サービス概要
ブラウザ上で簡単に服の組み合わせが試せるサービス。

## メインのターゲットユーザー
- ネットで服を購入したいけれど、その前に服の組み合わせを試してみたい人
- 服に興味があり、自分が持っていない服でもコーディネートを楽しんでみたい人

## ユーザーが抱える問題
- ネットで買おうとしている服と今持っている服を合わせたときのイメージが沸かない
- リアルだと、高くて買えないブランドはコーディネートできない

## 解決方法
- ブラウザで気軽に服の組み合わせを試せるようにする

## 実装予定の機能
- ゲストユーザー
    - 初期データから選択して組み合わせられる
    - 組み合わせたコーディネートを画像として保存できる
- 登録ユーザー
    - 自分が持っている服の写真をアップできる
    (背景はBackground Removal API(https://www.remove.bg/ja) を用いてアップ時に自動で切り取り)
- 管理ユーザー
    - データの追加、削除
- 導入していきたい機能
    - 過去に組み合わせたコーディネート一覧が見られる
    - 商品ページに飛べる

## なぜこのサービスを作りたいのか
- １つのルックを作るように、好きな服を自由に組み替えられたら楽しいと思ったから
- 大学時代にずっとアパレル販売のアルバイトをしていたため、どの組み合わせが格好良いかを常に考えていて、その体験をweb上で表現したいと思ったから
- ネットで買って失敗するリスクを下げたいから

## スケジュール
README〜ER図作成：12/31 〆切
メイン機能実装：1/1 - 2/28
β版をRUNTEQ内リリース（MVP）：3/1〆切
本番リリース：3/15

## 画面遷移図
https://www.figma.com/file/zZJsJyUjjlwYso0Krk0j2p/Untitled?node-id=58%3A2

## ER図
https://i.gyazo.com/82919bcc0aa783fb8c3816929b6b7271.png
