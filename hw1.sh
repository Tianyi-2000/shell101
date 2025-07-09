#!/bin/bash

# 读取参数：第一个是 Git 仓库地址，第二个是保存的本地目录名
GIT_URL="$1"
DIR_NAME="$2"

# ✅ 参数校验：确保用户输入了两个参数
if [ -z "$GIT_URL" ] || [ -z "$DIR_NAME" ]; then
    echo "❌ 用法错误："
    echo "正确格式是： ./auto_git_sync.sh <git_url> <local_folder>"
    echo "例如： ./auto_git_sync.sh https://github.com/user/repo.git hw1"
    exit 1
fi

# ✅ 检查目录是否已存在
if [ -d "$DIR_NAME" ]; then
    echo "📁 检测到目录 $DIR_NAME 已存在，尝试执行 git pull..."
    cd "$DIR_NAME" || { echo "❌ 无法进入目录 $DIR_NAME"; exit 1; }

    # 确保是一个 Git 仓库
    if [ -d ".git" ]; then
        git pull || { echo "❌ git pull 失败，请检查网络或权限。"; exit 1; }
    else
        echo "❌ 目录 $DIR_NAME 不是一个 Git 仓库。"
        exit 1
    fi

else
    # ✅ 克隆仓库
    echo "📂 目录 $DIR_NAME 不存在，开始克隆仓库..."
    git clone "$GIT_URL" "$DIR_NAME" || { echo "❌ 克隆失败，请检查 Git 地址是否正确。"; exit 1; }

    cd "$DIR_NAME" || { echo "❌ 克隆后无法进入目录 $DIR_NAME"; exit 1; }
fi

echo "✅ 操作完成！当前目录是：$(pwd)"

