FROM centos:centos6.9

MAINTAINER keisuke

ENV PATH $PATH:/usr/bin

RUN rpm -ivh http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm
RUN rpm -Uvh https://rpm.nodesource.com//pub_8.x/el/6/x86_64/nodejs-8.9.4-1nodesource.x86_64.rpm
RUN yum -y update
RUN yum -y install nginx gcc gcc-c++ git openssl-devel readline-devel zlib-devel mysql-devel wget
RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN wget http://ftp.tsukuba.wide.ad.jp/software/gcc/releases/gcc-7.3.0/gcc-7.3.0.tar.gz
RUN tar zxvf gcc-7.3.0.tar.gz
WORKDIR gcc-7.3.0
RUN pwd
RUN ./contrib/download_prerequisites
RUN mkdir build
WORKDIR build
RUN ../configure --enable-languages=c,c++ --prefix=/usr/local --disable-bootstrap --disable-multilib
RUN make
RUN make install
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
RUN echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
WORKDIR /usr/share/nginx/html
RUN source ~/.bash_profile && rbenv install 2.5.0 && rbenv rehash && rbenv global 2.5.0 && ruby -v && gem install bundler
RUN cp /usr/local/lib64/libstdc++.so.6 /usr/lib64/
CMD ["/bin/bash"]
