デプロイ手順

1. ec2 インスタンス作成
2. ８０番のセキュリティグループを開ける
3. ssh 経由で ec2 ログイン

4. git インストール&ソースコードダウンロード

```
export APP_DIR="testApiServer2"
export REPOSITORY_URL="https://github.com/chiaki1990/testApiServer2.git"

yum list | grep git
sudo yum install git.x86_64 -y
git clone "${REPOSITORY_URL}"
```

APP サーバー等起動

```
sudo chmod +x ./${APP_DIR}/deployment/deploy.sh && sudo sh ./{APP_DIR}/deployment/deploy.sh
```
