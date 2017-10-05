FROM drupal:8

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN composer global require drush/drush:~8
RUN ln -s /root/.composer/vendor/drush/drush/drush /bin/drush

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y mysql-client
RUN apt-get install -y vim

# Get latest version of Drupal, because the official image may
# be insecure for awhile after security updates.
RUN mkdir /var/www/latest-drupal
RUN cd /var/www/latest-drupal && drush dl
RUN cp -r /var/www/latest-drupal/drupal-*/* /var/www/html

EXPOSE 80
