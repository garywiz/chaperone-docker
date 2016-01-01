upstream django_sample {
     server unix:///tmp/django_sample.sock;
}

server {
	# .domain.com will match both domain.com and anything.domain.com
	server_name .%(CONFIG_EXT_HOSTNAME) "";
	listen 8080;
 
	# It is best to place the root of the server block at the server level, and not the location level
	# any location block path will be relative to this root. 
	root %(NGINX_SITES_DIR)/django_sample;
 
	# It's always good to set logs, note however you cannot turn off the error log
	# setting error_log off; will simply create a file called 'off'.
	access_log %(NGINX_LOG_DIR)/django_sample.access.log;
	error_log syslog:server=unix:/dev/log;
 
	# This block will catch static file requests and media.
	location /static {
	    alias %(APPS_DIR)/www/django_sample/static;
	}

	location /media {
	    alias %(APPS_DIR)/var/media;
	}

	# remove the robots line if you want to use wordpress' virtual robots.txt
	location = /robots.txt  { access_log off; log_not_found off; }
	location = /favicon.ico { access_log off; log_not_found off; }	
 
	# this prevents hidden files (beginning with a period) from being served
	location ~ /\.          { access_log off; log_not_found off; deny all; }
 
	location / {
	    uwsgi_pass  django_sample;
	    include %(APPS_DIR)/www/sites.d/uwsgi.inc;
	}
}

%(CONFIG_EXT_SSL_HOSTNAME:|?*|
# SSL Configuration for %(CONFIG_EXT_SSL_HOSTNAME)

server {
	# .domain.com will match both domain.com and anything.domain.com
	server_name .%(CONFIG_EXT_SSL_HOSTNAME) "";
	listen 8443;
 
	ssl on;
	ssl_certificate %(VAR_DIR)/certs/ssl-cert-snakeoil.pem;
	ssl_certificate_key %(VAR_DIR)/certs/ssl-cert-snakeoil.key;
	
	# It is best to place the root of the server block at the server level, and not the location level
	# any location block path will be relative to this root. 
	root %(NGINX_SITES_DIR)/django_sample;
 
	# It's always good to set logs, note however you cannot turn off the error log
	# setting error_log off; will simply create a file called 'off'.
	access_log %(NGINX_LOG_DIR)/django_sample-ssl.access.log;
	error_log syslog:server=unix:/dev/log;
 
	# This block will catch static file requests and media.
	location /static {
	    alias %(APPS_DIR)/www/django_sample/static;
	}

	location /media {
	    alias %(APPS_DIR)/var/media;
	}

	# remove the robots line if you want to use wordpress' virtual robots.txt
	location = /robots.txt  { access_log off; log_not_found off; }
	location = /favicon.ico { access_log off; log_not_found off; }	
 
	# this prevents hidden files (beginning with a period) from being served
	location ~ /\.          { access_log off; log_not_found off; deny all; }
 
	location / {
	    uwsgi_pass  django_sample;
	    include %(APPS_DIR)/www/sites.d/uwsgi.inc;
	}
}
|)
