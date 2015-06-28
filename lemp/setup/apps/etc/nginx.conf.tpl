# This file is processed by envcp.  See apps/etc/start_nginx.sh

# Interestingly, Nginx will attempt to write to /var/log/nginx/error.log no matter WHAT you do, so
# check there if you are having startup problems, but the following should at least assure
# that things go to syslog whenever Nginx deems fit.
error_log syslog:server=unix:/dev/log;

worker_processes 4;
working_directory ${APPS_DIR};

pid ${NGINX_PID_FILE};

events {
	worker_connections 768;
	# multi_accept on;
}

http {

	##
	# Basic Settings
	##

	sendfile on;
	tcp_nopush on;
	tcp_nodelay on;
	keepalive_timeout 65;
	types_hash_max_size 2048;
	# server_tokens off;

	# server_names_hash_bucket_size 64;
	# server_name_in_redirect off;

        # Set an array of temp and cache file options that will otherwise default to
	# restricted locations accessible only to root.
	client_body_temp_path /tmp/client_body;
	fastcgi_temp_path /tmp/fastcgi_temp;
	proxy_temp_path /tmp/proxy_temp;
	scgi_temp_path /tmp/scgi_temp;
	uwsgi_temp_path /tmp/uwsgi_temp;

	include /etc/nginx/mime.types;
	default_type application/octet-stream;

	##
	# Logging Settings
	##

	access_log ${NGINX_LOG_DIR}/access.log;

	##
	# Gzip Settings
	##

	gzip on;
	gzip_disable "msie6";

	# gzip_vary on;
	# gzip_proxied any;
	# gzip_comp_level 6;
	# gzip_buffers 16 8k;
	# gzip_http_version 1.1;
	# gzip_types text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript;

	##
	# nginx-naxsi config
	##
	# Uncomment it if you installed nginx-naxsi
	##

	#include /etc/nginx/naxsi_core.rules;

	##
	# nginx-passenger config
	##
	# Uncomment it if you installed nginx-passenger
	##
	
	#passenger_root /usr;
	#passenger_ruby /usr/bin/ruby;

	##
	# Virtual Host Configs
	##

	include ${APPS_DIR}/var/sites.d/*.conf;
}
