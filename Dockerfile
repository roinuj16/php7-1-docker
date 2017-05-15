FROM php:7.1-apache

MAINTAINER Edson Junior <junior.si16@gmail.com>


RUN echo "\033[1;37m <--- Atualizando e instalando dependencias de configuração --->  \033[0m " && \
	apt-get update && \
	apt-get install -y \
	apt-utils \
	# pkg-config \
	openssh-client \
	vim \
	git \
	libldap2-dev \
	libcurl4-gnutls-dev \
	curl \
	libicu-dev \
	libmcrypt-dev \
	libvpx-dev \
	libjpeg-dev \
	libpng-dev \
	libxpm-dev \
	zlib1g-dev \
	libfreetype6-dev \
	libxml2-dev \
	libexpat1-dev \
	libbz2-dev \
	libgmp3-dev \
	libldap2-dev \
	unixodbc-dev \
	libpq-dev \
	libsqlite3-dev \
	libaspell-dev \
	libsnmp-dev \
	libpcre3-dev \
	libtidy-dev \
	build-essential \
	libkrb5-dev \
	libedit-dev \
	libedit2 \
	gcc \
	libmcrypt4 \
	make \
	python2.7-dev \
	python-pip \
	re2c \
	wget \
	sqlite3 \
	libmemcached-dev \
	libc-client-dev -yqq \
	&& rm -rf /var/lib/apt/lists/*

	
RUN echo "\033[1;37m <--- Instalando o Composer --->  \033[0m " && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
    

RUN echo "\033[1;37m <--- Incluindo Extensões --->  \033[0m "
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ 
RUN docker-php-ext-configure imap --with-imap-ssl --with-kerberos --with-imap

RUN echo "\033[1;37m <--- Instalando libs do PHP ---> \033[0m "
RUN docker-php-ext-install mbstring \
   mcrypt \
   pdo_mysql \
   curl \
   json \
   intl \
   gd \
   xml \
   zip \
   bz2 \
   opcache \
   pgsql \
   pdo_sqlite\
   intl \
   bcmath \
   soap \
   ldap \
   imap

WORKDIR /var/www/app
   
RUN echo "\033[1;37m <--- Habilitando modo rewrite ---> \033[0m "  
RUN a2enmod rewrite
