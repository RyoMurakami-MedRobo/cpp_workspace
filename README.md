# C++ Workspace

このリポジトリは、C++関連の設定ファイル、テストコード、およびプロジェクトテンプレートを管理するためのワークスペースです。

## ディレクトリ構造

```
cpp_workspace/
├── src/          # ソースコード
├── include/      # ヘッダーファイル
├── test/         # テストコード
├── examples/     # サンプルコード
├── build/        # ビルド成果物（gitignore対象）
└── .vscode/      # VSCode設定ファイル
```

## セットアップ

### 必要なツール

- C++17対応のコンパイラ（clang++推奨）
- CMake（オプション）

### ビルド方法

```bash
# CMakeを使用する場合
mkdir -p build
cd build
cmake ..
make

# 直接コンパイルする場合
clang++ -std=c++17 -o output src/main.cpp
```

## VSCode設定

`.vscode/c_cpp_properties.json` にC++のIntelliSense設定が含まれています。
Mac環境用に最適化されています。

## ライセンス

このリポジトリは個人の開発用ワークスペースです。

