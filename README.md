# PoetryとDockerを用いたPyTorch環境構築サンプル

## はじめに

- 2022年11月時点のPoetryとDockerを用いたPyTorch環境を構築したサンプルです。

- PyTorch以外に深層学習でよく使うライブラリのインストールとLinter, Formatterの設定をします。

- 研究室の各自のPCから深層学習用サーバー上のRemote Containerに接続する場合のみ動作確認済みです。

- PoetryとPyTorchの相性が悪いので、今後の更新次第では環境構築に失敗する可能性があります。

## 動作環境

以下の環境で動作確認済み

- Ubuntu 22.04
- Git 2.34.1
- Docker 20.10.18
- CUDA Drive (nvidia driver) 520.61.05

## 環境構築手順

0. Docker, SSH, Dev Containerについて勉強 

1. サーバーにGit, Docker, docker-compose, CUDA, nvidia-container-toolkitをインストール（研究室の一部のサーバーではインストール済み）

    - [NVIDIA container toolkitを使って、dockerのコンテナ上でcudaを動かす](https://qiita.com/Hiroaki-K4/items/c1be8adba18b9f0b4cef)
    
2. サーバー上の適当なフォルダにclone

    ```
    git clone https://github.com/bisbislab/pytorch_poetry_docker_sample.git
    ```
    
3. VSCodeの拡張機能Remote Developmentをインストール

    - Remote DevelopmentはWSL, Dev Containers, Remote - SSHの3つの拡張機能をまとめてインストールしてくれます。
    
4. Remote - SSHを使って2でcloneしたサーバー上のpytorch_poetry_docker_sampleフォルダを開く

5. 現在ログイン中のIDなどを`.env`に書き込む
    
    - 以下のコマンドでuser_name, uid, gidを調べる
    
        ```
        $ id
        ```
        
        出力例
        ```
        uid=9999(user_name) gid=9999(group_name) groups=9999(group_name)
        ```

    - `.env.example`をコピペして`.env`を作成して先ほど調べたuser_name, uid, gidを記述

        ```
        USER_NAME=user_name
        USER_UID=9999
        USER_GID=9999
        ```

6. Dev Containersを使ってコンテナ環境に入る

    - ビルドに5分くらいかかります。

7. PyTorchでCUDAが使えるか確認

    - main.pyはCUDAが利用可能か判定するコードです。

        ```
        python main.py
        ```

## Linter, Formatterについて

- 以下のLinter, Formatterがインストールされます。
    
    - black
    - isort
    - mypy
    - flake8 (pyproject-flake8)

- Dev Containersで起動することで保存するたびに自動でフォーマットがかかります。
- 各種設定は [pyproject.toml](/pyproject.toml), [devcontainer.json](/.devcontainer/devcontainer.json) を確認してください。

## 参考文献

- [NVIDIA container toolkitを使って、dockerのコンテナ上でcudaを動かす](https://qiita.com/Hiroaki-K4/items/c1be8adba18b9f0b4cef)

- [任意のCUDAバージョンのPyTorchをPoetryでインストールする](https://zenn.dev/yag_ays/articles/a6c84622f558ee)

- [Add a non-root user to a container (Dev Containers 公式ドキュメント)](https://code.visualstudio.com/remote/advancedcontainers/add-nonroot-user)