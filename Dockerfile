FROM php:7.4
RUN apt-get update -yqq
RUN apt-get install git unzip -yqq
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === 'a5c698ffe4b8e849a443b120cd5ba38043260d5c4023dbf93e1558871f1f07f58274fc6f4c93bcfd858c6bd0775cd8d1') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN docker-php-ext-install pdo_mysql mysqli
RUN apt-get install -y zlib1g-dev
RUN apt-get install -y libpng-dev
RUN docker-php-ext-install gd
RUN adduser --disabled-password -gecos "" application
RUN su - application -c "composer global require hirak/prestissimo"
