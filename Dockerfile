FROM phusion/baseimage:0.9.22


# Nginx-PHP Installation
RUN  sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list
RUN  apt-get clean

RUN apt-get update -y && apt-get install -y wget build-essential python-software-properties git-core vim nano
RUN wget -O - https://download.newrelic.com/548C16BF.gpg | apt-key add - && \
	echo "deb http://apt.newrelic.com/debian/ newrelic non-free" > /etc/apt/sources.list.d/newrelic.list
RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 4F4EA0AAE5267A6C
RUN add-apt-repository -y ppa:ondrej/php && add-apt-repository -y ppa:nginx/stable
RUN apt-get update -y && apt-get upgrade -y && apt-get install -q -y php5.6 php5.6-dev php5.6-fpm php5.6-mysqlnd \
	php5.6-pgsql php5.6-curl php5.6-gd php5.6-mbstring php5.6-mcrypt php5.6-intl php5.6-imap php5.6-tidy \
	php5.6-xml php5.6-xmlrpc zip unzip php5.6-zip newrelic-php5 nginx-full ntp

# Create new symlink to UTC timezone for localtime
RUN unlink /etc/localtime
RUN ln -s /usr/share/zoneinfo/UTC /etc/localtime

# Update PECL channel listing
RUN pecl channel-update pecl.php.net



# Cleanup apt and lists
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*