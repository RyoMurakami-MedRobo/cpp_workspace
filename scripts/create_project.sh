#!/bin/bash

# 新しいC++プロジェクトを作成するスクリプト
# 使用方法: ./scripts/create_project.sh <project_name> [--git]
# オプション:
#   --git: Gitリポジトリを初期化する

INIT_GIT=false

# 引数の解析
if [ $# -eq 0 ]; then
    echo "使用方法: $0 <project_name> [--git]"
    echo "例: $0 research_theme_1"
    echo "例: $0 research_theme_1 --git  # Gitリポジトリも初期化"
    exit 1
fi

PROJECT_NAME=$1

# --gitオプションのチェック
if [ "$2" == "--git" ]; then
    INIT_GIT=true
fi

PROJECT_DIR="projects/$PROJECT_NAME"
TEMPLATE_DIR="templates/basic_cpp_project"

# プロジェクトディレクトリが既に存在するかチェック
if [ -d "$PROJECT_DIR" ]; then
    echo "エラー: プロジェクト '$PROJECT_NAME' は既に存在します。"
    exit 1
fi

# テンプレートからプロジェクトを作成
echo "プロジェクト '$PROJECT_NAME' を作成中..."
cp -r "$TEMPLATE_DIR" "$PROJECT_DIR"

# CMakeLists.txtのプロジェクト名を変更
sed -i '' "s/project(ProjectName/project($PROJECT_NAME/g" "$PROJECT_DIR/CMakeLists.txt"

# README.mdのプロジェクト名を変更
sed -i '' "s/# Project Name/# $PROJECT_NAME/g" "$PROJECT_DIR/README.md"

# Gitリポジトリの初期化
if [ "$INIT_GIT" = true ]; then
    echo ""
    echo "Gitリポジトリを初期化中..."
    cd "$PROJECT_DIR"
    git init
    git add .
    git commit -m "Initial commit: $PROJECT_NAME"
    cd - > /dev/null
    echo "Gitリポジトリが初期化されました。"
fi

echo ""
echo "プロジェクト '$PROJECT_NAME' が正常に作成されました。"
echo "ディレクトリ: $PROJECT_DIR"
echo ""
echo "次のステップ:"
echo "  cd $PROJECT_DIR"
echo "  mkdir -p build && cd build"
echo "  cmake .."
echo "  make"
if [ "$INIT_GIT" = true ]; then
    echo ""
    echo "GitHubリポジトリを作成する場合:"
    echo "  1. GitHubで新しいリポジトリを作成"
    echo "  2. 以下のコマンドを実行:"
    echo "     cd $PROJECT_DIR"
    echo "     git remote add origin https://github.com/YOUR_USERNAME/$PROJECT_NAME.git"
    echo "     git branch -M main"
    echo "     git push -u origin main"
fi

