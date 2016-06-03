FROM ubuntu:14.04

RUN apt-get update && apt-get install -y apache2 libapache2-mod-wsgi
RUN mkdir -p /var/lock/apache2 /var/run/apache2

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2
ENV LANG C

COPY wsgi.conf /etc/apache2/sites-available/hil.conf
COPY haas.wsgi /var/www/haas/haas.wsgi

RUN a2dissite 000-default && a2ensite hil

RUN chown -R www-data:www-data /var/www

RUN apt-get update && apt-get install -y git python-pip python-dev python-lxml curl

RUN git clone https://github.com/CCI-MOC/haas.git && cd haas && \
    python setup.py install

COPY haas.cfg /etc/haas.cfg
RUN chown www-data:www-data /etc/haas.cfg

CMD ["apachectl", "-DFOREGROUND"]
EXPOSE 80