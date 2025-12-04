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

### 🌟 推奨方法：各プロジェクトを独立したGitリポジトリとして管理（GitHubリポジトリも分離）

**各研究テーマを独立したGitリポジトリとして管理し、それぞれを別々のGitHubリポジトリにプッシュする方法です。**

#### なぜこの方法が現代において推奨されるのか

現代のソフトウェア開発では、**マルチレポ構造（Multi-repo）**が多くの場合で推奨されます。特に研究テーマのような独立したプロジェクトを管理する場合、以下の理由からこの方法が最適です：

**✅ メリット**:
- **独立したライフサイクル**: 各研究テーマが異なる開発速度やライフサイクルを持てる
- **柔軟なアクセス制御**: GitHubでテーマごとに異なる共同研究者やアクセス権限を設定可能
- **個別のCI/CD設定**: 各プロジェクトに最適化されたビルド・テスト・デプロイパイプラインを設定可能
- **明確な責任分離**: 各プロジェクトの履歴が明確に分離され、コードレビューやイシュー管理が容易
- **公開設定の柔軟性**: 一部のテーマは公開、他は非公開など、個別に設定可能
- **リポジトリサイズの最適化**: 各リポジトリが小さく保たれ、クローンや操作が高速
- **依存関係の明確化**: 各プロジェクトの依存関係が明確で、不要な依存を避けられる

**⚠️ デメリット**:
- 共通コードの共有がやや複雑（ただし、GitHubのテンプレートやサブモジュールで対応可能）
- 複数のリポジトリを管理する必要がある（ただし、ワークスペースで一元管理可能）

#### どのような場合にこの方法を選ぶべきか

✅ **この方法が適している場合**:
- 各研究テーマが独立したプロジェクトである
- 異なる共同研究者やアクセス権限が必要
- テーマごとに異なる公開設定が必要
- 各プロジェクトが異なるライフサイクルを持つ
- プロジェクト間の依存関係が少ない

❌ **この方法が適さない場合**:
- すべてのテーマが密接に関連しており、常に一緒に開発される
- 共通コードの変更を全プロジェクトに即座に反映する必要がある
- チーム全体で統一された開発フローを維持する必要がある（大規模組織のモノレポ）

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

### 方法2：モノレポ構造（Monorepo - 単一リポジトリ）

一つのリポジトリ内で複数のプロジェクトを管理する方法です。各研究テーマを独立したサブディレクトリとして配置します。

#### モノレポの特徴

**✅ メリット**:
- 共通コードの変更を全プロジェクトに即座に反映可能
- 一括での検索・リファクタリングが容易
- 統一された開発フローとツールチェーン
- 単一のCI/CDパイプラインで全プロジェクトを管理

**⚠️ デメリット**:
- リポジトリサイズが大きくなり、クローンに時間がかかる
- アクセス権限の細かい制御が難しい（全プロジェクトへのアクセスが必要）
- 個別の公開設定ができない（すべて公開またはすべて非公開）
- プロジェクト間の依存関係が複雑になりやすい

#### どのような場合にモノレポを選ぶべきか

✅ **モノレポが適している場合**:
- すべての研究テーマが密接に関連している
- 共通ライブラリやコードを頻繁に共有・更新する
- 統一された開発環境とフローを維持したい
- 小規模なチームで、すべてのプロジェクトにアクセス権限がある

**現代の傾向**: 大規模な組織（Google、Meta、Microsoftなど）ではモノレポが採用されることがありますが、これらは専用のツールとインフラが必要です。個人や小規模チームの研究プロジェクトでは、**独立したリポジトリの方が管理しやすく推奨されます**。

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

## 方法の選択指針

### 推奨される選択フロー

```
研究テーマは独立しているか？
├─ YES → 独立したGitリポジトリ（方法1）⭐ 推奨
│         └─ 各テーマを別々のGitHubリポジトリで管理
│
└─ NO → テーマ間の関連性は？
    ├─ 密接に関連 → モノレポ（方法2）
    │   └─ 一つのGitHubリポジトリで全テーマを管理
    │
    └─ 完全に独立 → 独立したGitリポジトリ（方法1）⭐ 推奨
```

### まとめ

**現代の開発において、研究テーマのような独立したプロジェクトを管理する場合、各プロジェクトを独立したGitリポジトリとして管理する方法（方法1）が最も推奨されます。**

この方法により：
- ✅ 各プロジェクトの独立性が保たれる
- ✅ GitHubでの柔軟な管理が可能
- ✅ 現代の開発プラクティスに適合
- ✅ スケーラブルで保守しやすい構造

ワークスペースのテンプレートやスクリプトを活用することで、共通設定を共有しつつ、各プロジェクトを独立して管理できます。

## ライセンス

このリポジトリは個人の開発用ワークスペースです。

