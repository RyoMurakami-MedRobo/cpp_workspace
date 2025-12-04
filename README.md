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

## 複数の研究テーマを管理する方法

複数の研究テーマごとに別々のC++プロジェクトを開発する場合、以下の方法が推奨されます。

### 推奨方法：各プロジェクトを独立したGitリポジトリとして管理（GitHubリポジトリも分離）

**各研究テーマを独立したGitリポジトリとして管理し、それぞれを別々のGitHubリポジトリにプッシュする方法です。**

この方法のメリット：
- ✅ 各研究テーマが完全に独立したGit履歴を持つ
- ✅ GitHubで各テーマごとに別々のリポジトリとして管理できる
- ✅ テーマごとのアクセス権限や公開設定を個別に設定可能
- ✅ ワークスペースのテンプレートやスクリプトは共有できる
- ✅ 各プロジェクトの開発履歴が明確に分離される

#### ディレクトリ構造の例

```
cpp_workspace/
├── projects/                    # 研究テーマごとのプロジェクト（各プロジェクトは独立したGitリポジトリ）
│   ├── research_theme_1/       # 研究テーマ1（独立したGitリポジトリ）
│   │   ├── .git/              # Gitリポジトリ
│   │   ├── CMakeLists.txt
│   │   ├── src/
│   │   ├── include/
│   │   ├── test/
│   │   └── build/
│   ├── research_theme_2/       # 研究テーマ2（独立したGitリポジトリ）
│   │   ├── .git/              # Gitリポジトリ
│   │   ├── CMakeLists.txt
│   │   ├── src/
│   │   ├── include/
│   │   ├── test/
│   │   └── build/
│   └── research_theme_3/       # 研究テーマ3（独立したGitリポジトリ）
│       ├── .git/              # Gitリポジトリ
│       ├── CMakeLists.txt
│       ├── src/
│       ├── include/
│       ├── test/
│       └── build/
├── templates/                   # プロジェクトテンプレート
│   └── basic_cpp_project/
├── scripts/                     # プロジェクト作成スクリプト
│   └── create_project.sh
├── CMakeLists.txt              # ワークスペース用CMakeLists
├── examples/                   # 共通のサンプルコード
└── README.md
```

**注意**: `projects/`ディレクトリ内の各プロジェクトは独立したGitリポジトリとして管理されるため、メインのワークスペースリポジトリでは無視されます（`.gitignore`で設定済み）。

#### 新しい研究テーマプロジェクトの作成方法（Gitリポジトリ付き）

1. **スクリプトを使用してGitリポジトリも初期化する場合（推奨）**:
   ```bash
   ./scripts/create_project.sh research_theme_name --git
   ```
   このスクリプトは、テンプレートからプロジェクトを作成し、Gitリポジトリも初期化します。

2. **Gitリポジトリなしで作成し、後で初期化する場合**:
   ```bash
   ./scripts/create_project.sh research_theme_name
   cd projects/research_theme_name
   git init
   git add .
   git commit -m "Initial commit"
   ```

#### GitHubリポジトリへの接続方法

各プロジェクトを独立したGitHubリポジトリとして管理する手順：

1. **GitHubで新しいリポジトリを作成**
   - GitHubのウェブサイトで新しいリポジトリを作成（例: `research_theme_1`）
   - README、.gitignore、ライセンスは追加しない（既にプロジェクトに含まれているため）

2. **ローカルプロジェクトをGitHubリポジトリに接続**
   ```bash
   cd projects/research_theme_name
   git remote add origin https://github.com/YOUR_USERNAME/research_theme_name.git
   git branch -M main
   git push -u origin main
   ```

3. **今後の変更をプッシュ**
   ```bash
   cd projects/research_theme_name
   git add .
   git commit -m "Your commit message"
   git push
   ```

#### 各プロジェクトのビルド方法

各プロジェクトは独立してビルドできます：

```bash
# 研究テーマ1をビルド
cd projects/research_theme_1
mkdir -p build && cd build
cmake ..
make
```

### 方法2：モノレポ構造（単一リポジトリ）

一つのリポジトリ内で複数のプロジェクトを管理する方法です。各研究テーマを独立したサブディレクトリとして配置します。

**この方法は、すべての研究テーマを一つのGitHubリポジトリで管理したい場合に適しています。**

#### ディレクトリ構造の例

```
cpp_workspace/
├── projects/                    # 研究テーマごとのプロジェクト
│   ├── research_theme_1/       # 研究テーマ1
│   │   ├── CMakeLists.txt
│   │   ├── src/
│   │   ├── include/
│   │   ├── test/
│   │   └── build/
│   ├── research_theme_2/       # 研究テーマ2
│   │   ├── CMakeLists.txt
│   │   ├── src/
│   │   ├── include/
│   │   ├── test/
│   │   └── build/
│   └── research_theme_3/       # 研究テーマ3
│       ├── CMakeLists.txt
│       ├── src/
│       ├── include/
│       ├── test/
│       └── build/
├── templates/                   # プロジェクトテンプレート（オプション）
│   └── basic_cpp_project/
├── CMakeLists.txt              # ルートCMakeLists（オプション）
├── examples/                   # 共通のサンプルコード
└── README.md
```

#### 新しい研究テーマプロジェクトの作成方法（Gitリポジトリなし）

1. **スクリプトを使用する場合**:
   ```bash
   ./scripts/create_project.sh research_theme_name
   ```
   このスクリプトは、テンプレートからプロジェクトを作成し、プロジェクト名を自動的に設定します。

2. **手動で作成する場合**:
   ```bash
   mkdir -p projects/research_theme_name/{src,include,test,build}
   cp templates/basic_cpp_project/CMakeLists.txt projects/research_theme_name/
   cp -r templates/basic_cpp_project/src projects/research_theme_name/
   # CMakeLists.txtのPROJECT名を適切に変更
   ```

#### 各プロジェクトのビルド方法

各プロジェクトは独立してビルドできます：

```bash
# 研究テーマ1をビルド
cd projects/research_theme_1
mkdir -p build && cd build
cmake ..
make
```

#### ルートCMakeListsで全プロジェクトを管理（オプション）

ルートの`CMakeLists.txt`を以下のように設定すると、すべてのプロジェクトを一度に管理できます：

```cmake
cmake_minimum_required(VERSION 3.10)
project(CppWorkspace VERSION 1.0.0 LANGUAGES CXX)

# 各研究テーマプロジェクトを追加
add_subdirectory(projects/research_theme_1)
add_subdirectory(projects/research_theme_2)
add_subdirectory(projects/research_theme_3)
```

### 方法3：完全に別々のディレクトリで管理

各研究テーマをワークスペースとは完全に別の場所で管理する方法です。

- **メリット**: 完全に独立した管理が可能
- **デメリット**: 共通設定の共有が難しい

```bash
# 各テーマごとに別ディレクトリでリポジトリを作成
mkdir ~/Documents/GitHub/research_theme_1
cd ~/Documents/GitHub/research_theme_1
git init
# テンプレートからファイルをコピーして使用
```

## ライセンス

このリポジトリは個人の開発用ワークスペースです。

