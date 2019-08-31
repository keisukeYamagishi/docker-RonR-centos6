# README

## over view

nginx
Ruby on Rails
centos
mysql 5.7

## Use it

docker build

```bash
docker-compose build
docker-compose up -d
```

docker login

```bash
source ~/.bash_profile
cd /usr/share/nginx/html
bundle install
bundle exec unicorn_rails -c config/unicorn.rb -E development -D
service nginx start
```
http://localhost:3000
