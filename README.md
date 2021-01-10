# Server-kun
Server-kun はGoogle Compute Engine(GCE)インスタンスをいい感じにDiscord経由で管理してくれるbotになる予定です。

## 機能
- Discordの書き込みに応じてインスタンスを起動/停止
- Discordの書き込みに応じてインスタンスのメトリクスを表示
- CPU使用率が一定以下になるとインスタンスを停止


## 事前準備

1. GCEサーバ(permanent)を用意する。
    1. golangを導入する
    1. Dockerとdocker-composeを導入する

## 使い方

1. CloudFunctionにデプロイをおこなう
    1. functions/start & functions/stop
        1. .env.yamlを設置
        1. helper.shを参考にCloudFunctionにDeploy
    1. functions/autostop
        1. .env.yamlを設置
        1. helper.shを参考にCloudFunctionにDeploy
2. 永続サーバにreceiverを設置して起動する
    2. apps/.envファイルに環境変数を設定
    2. apps/で ```docker-compose build``` を実行する
    2. server-kun.serviceをsystemdに登録して起動する
        2. apps/service/server-kun.service 内の実行ユーザー名とディレクトリ名を編集すること
        2. /etc/systemd/system あたりに server-kun.service を設置する

```yaml:functions/start/.env.yaml
SERVER_PROJECT: GCPプロジェクトID
SERVER_ZONE: 操作するGCEインスタンスがあるZone
SERVER_INSTANCE: 操作するGCEインスタンス名
```

```yaml:functions/stop/.env.yaml
SERVER_PROJECT: GCPプロジェクトID
SERVER_ZONE: 操作するGCEインスタンスがあるZone
SERVER_INSTANCE: 操作するGCEインスタンス名
```

```yaml:functions/autostop/.env.yaml
DISCORD_HOOK: DiscordのWebHookURL
AUTOSTOP_MESSAGE: 自動停止時のメッセージ
STOP_HOOK: CloudFunctionのTriggerURI
```

```shell:apps/.env
START_TRIGGER="サーバ起動のトリガーにするメッセージ"
STOP_TRIGGER="サーバ停止のトリガーにするメッセージ"
START_MESSAGE="サーバ起動時に表示するメッセージ"
STOP_MESSAGE="サーバ停止時に表示するメッセージ"
DISCORD_TOKEN="Discord BotのToken"
START_HOOK="CloudFunctionのTriggerURI"
STOP_HOOK="CloudFunctionのTriggerURI"
```
