# 同一リソースを複数つくる場合に個別の設定が無ければ共通設定を使用する

## やりたいこと

同一リソース（Pod）を複数つくりたい。
Podのマニフェストの設定は、Podごとに設定があればそれを、無ければ共通で設定した値を使用したい。


## ディレクトリ構成

```txt
.
├── README.md
└── chart
    ├── Chart.yaml
    ├── templates
    │   ├── _helpers.tpl           # 個別の設定があればそれを、無ければ共通の設定を取得するヘルパー関数を定義する
    │   ├── pod-one-by-one.yaml    # values.yaml に記載した Pod それぞれに対してテンプレートを定義する
    │   └── pod-standardized.yaml  # values.yaml に記載した複数の Pod に共通のテンプレートを定義する
    └── values.yaml                # Pod 2 つと共通の設定値を記したファイル
```


## マニフェスト確認方法

```sh
helm install --dry-run --debug multi-resources-with-same-settings ./chart
```


## 詳細

- **values.yaml**
    - Pod A、Pod B、共通設定を記したファイル。
    - Pod A はテンプレートで必要な全ての設定を記載。
    - Pod B は個別の設定は記載せず、全ての設定は共通設定を使用するものとする。

- **pod-one-by-one.yaml**
    - Pod A と Pod B それぞれに対するテンプレートを記載したファイル。
    - 目的を満たすヘルパー関数の作成を一歩ずつコーディングしていくために用意。

- **pod-standardized.yaml**
    - Pod A と Pod B に対し共通のテンプレートを適用できるようにしたファイル。
    - この Helm Chart テンプレートの最終形。

- **_helpers.tpl**
    - 個別の設定があればそれを、無ければ共通の設定を取得するヘルパー関数群。


## 動作確認環境

- macOS Monterey 12.6
- docker desktop 4.11.1
    - Engine : 20.10.17
    - Kubernetes : v1.24.2
