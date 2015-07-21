server {
	# .domain.com will match both domain.com and anything.domain.com
	server_name .example.com "";
	listen 8080;
 
	# It is best to place the root of the server block at the server level, and not the location level
	# any location block path will be relative to this root. 
	root $(NGINX_SITES_DIR)/default;
 
	# It's always good to set logs, note however you cannot turn off the error log
	# setting error_log off; will simply create a file called 'off'.
	access_log $(NGINX_LOG_DIR)/default.access.log;
	error_log syslog:server=unix:/dev/log;
 
	# This can also go in the http { } level
	index index.html index.htm index.php;
 
	location / { 
		# if you're just using wordpress and don't want extra rewrites
		# then replace the word @rewrites with /index.php
		try_files $uri $uri/ @rewrites;
	}
 
	location @rewrites {
		# Can put some of your own rewrite rules in here
		# for example rewrite ^/~(.*)/(.*)/? /users/$1/$2 last;
		# If nothing matches we'll just send it to /index.php
		rewrite ^ /index.php last;
	}
 
	# This block will catch static file requests, such as images, css, js
	# The ?: prefix is a 'non-capturing' mark, meaning we do not require
	# the pattern to be captured into $1 which should help improve performance
	location ~* \.(?:ico|css|js|gif|jpe?g|png)$ {
		# Some basic cache-control for static files to be sent to the browser
		expires max;
		add_header Pragma public;
		add_header Cache-Control "public, must-revalidate, proxy-revalidate";
	}
 
	# remove the robots line if you want to use wordpress' virtual robots.txt
	location = /robots.txt  { access_log off; log_not_found off; }
	location = /favicon.ico { access_log off; log_not_found off; }	
 
	# this prevents hidden files (beginning with a period) from being served
	location ~ /\.          { access_log off; log_not_found off; deny all; }
 
	location /phpmyadmin {
	        root /usr/share;
	        include ${VAR_DIR}/sites.d/php-fast.inc;
		location ~* \.(?:ico|css|js|gif|jpe?g|png)$ {
			# Some basic cache-control for static files to be sent to the browser
			expires max;
			add_header Pragma public;
			add_header Cache-Control "public, must-revalidate, proxy-revalidate";
		}
	}

	location ~ \.php {
	        include ${VAR_DIR}/sites.d/php-fast.inc;
	}
}
