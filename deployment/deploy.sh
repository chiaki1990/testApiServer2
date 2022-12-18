#!/bin/bash

# 環境変数の引き継ぐためsudo -s実行後環境変数とデプロイスクリプトを実行する
# 設定項目
# export REPOSITORY_URL="https://github.com/chiaki1990/testApiServer2.git"
# export APP_DIR="testApiServer2"
# export PGDATABASE=
# export PGUSER=
# export PGPASSWORD=
# export DBPORT=




# nginxインストール＆起動

## nginxインストール 
amazon-linux-extras list | grep nginx
sudo amazon-linux-extras install nginx1 -y

## nginx 設定ファイル
sudo \cp ./${APP_DIR}/nginx/nginx.conf /etc/nginx/nginx.conf

## nginx の設定確認
# sudo nginx -t

## nginx起動
sudo systemctl restart nginx
sudo systemctl enable nginx


# postgresqインストール
sudo amazon-linux-extras list | grep postgres
sudo amazon-linux-extras install -y postgresql14
sudo yum install -y postgresql-server postgresql-devel

# postgresql初期化
sudo /usr/bin/postgresql-setup --initdb

\sudo cp -f ./${APP_DIR}/database/pg_hba.conf /var/lib/pgsql/data/pg_hba.conf
# postgresql起動
sudo systemctl restart postgresql
sudo systemctl enable postgresql

psql -V

sudo psql -d postgres -U postgres -f ./${APP_DIR}/database/init/ddl.sql
sudo psql -d postgres -U postgres -f ./${APP_DIR}/database/init/seed.sql
echo ${PGPASSWORD}
echo '${PGPASSWORD}'
echo "'${PGPASSWORD}'"
echo "${PGPASSWORD}"
echo "ALTER USER postgres WITH PASSWORD '${PGPASSWORD}';"
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD '${PGPASSWORD}';"

# ランタイムインストール&アプリサーバー起動
sudo amazon-linux-extras list | grep golang
sudo amazon-linux-extras install golang1.11 -y

# アプリサーバー起動
echo ${APP_DIR}
cd ./${APP_DIR} && go build -o dist


./dist/go-sample
