<!DOCTYPE html>
<?php
   $appsdir = getenv("APPS_DIR");
   $appsdirtt = "<tt>" . $appsdir . "</tt>";
   $pagename = getenv("HTTPD_SERVER_NAME") . "+php container";

function highlight($instr, $words) {
   return preg_replace("/.+(".$words.")/", "<span class='ls-high'>$0</span>", $instr);
}
   ?>
<html>
  <head>
    <title><?php echo $pagename; ?> - Home</title>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    
    <link rel="stylesheet" type="text/css" href="style.css" />
    <link href='http://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,700,400italic,700italic&subset=latin,latin-ext' rel='stylesheet' type='text/css' />
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,700,400italic,700italic&subset=latin,latin-ext' rel='stylesheet' type='text/css' />

  </head>
  <body class="landing-page  wsite-theme-light  wsite-page-index"><div class="top-background">
      <div id="header-wrap">
	<div class="container">
	  <td class="search"></td>
	</div><!-- end container -->
      </div><!-- end header-wrap -->
      
      <div id="nav-wrap">
	<div class="container header-align-outer">
	  <div class="header-align-mid">
	    <div class="header-align-inner">
	      <div class="built-with">
		  <img style="height:25px;vertical-align:middle" src="images/chaplogo-150627.svg"/>&nbsp;<span style="vertical-align:middle">Built with Chaperone + Docker</span>
	      </div>
	      <div id="logo"><span class="wsite-logo">
		  <a href="">
		    <span id="wsite-title"><?php echo $pagename; ?></span>
		  </a>
		</span>
		<div class="nav-spacer"></div>
		<div class="nav-container">
		  <ul class="wsite-menu-default">
		    <li class="wsite-menu-item-wrap">
		      <a href="index.php" class="wsite-menu-item">
			Default Site Home
		      </a>
		    </li>
		    <li class="wsite-menu-item-wrap">
		      <a href="about.php" class="wsite-menu-item">
			About Chaperone
		      </a>
		    </li>
		    <li id="active" class="wsite-menu-item-wrap">
		      <a href="resources.php" class="wsite-menu-item">
			Resources
		      </a>
		    </li>
		  </ul>
		</div>
	      </div><!-- end header align inner -->
	    </div><!-- end header align mid -->
	  </div><!-- end container -->	
	</div><!-- end top background -->

	<div id="main-wrap-alone">
	  <div class="container">

	    <div id='wsite-content' class='wsite-elements wsite-not-footer'>
	      <h2 class="wsite-content-title" style="text-align:left;">More on Chaperone ...</h2>

	      <div class="paragraph" style="text-align:left;">
		Chaperone is a newly developed tool designed specifically to manage multi-process containers.
		It is a single, self-contained process which provides:
		<ul>
		  <li>Dependency-based start-up.</li>
		  <li>Built-in syslog capability so you can redirect log output wherever you want.</li>
		  <li>Systemd notification emulation for daemons which support it.</li>
		  <li>Control sockets and the <tt>telchap</tt> utility to start and stop services.</li>
		  <li>Simple configuration.</li>
		  <li>and more...</li>
		</ul>
		Here are some links to source code and documentation:
		<ul>
		  <li><a href="https://github.com/garywiz/chaperone">chaperone source code on github</a></li>
		  <li><a href="http://garywiz.github.io/chaperone">Full Documentation</a></li>
		  <li><a href="https://github.com/garywiz/chaperone-docker">chaperone-docker: builder code for 
		      Docker Hub images</a></li>
		</ul>
		Plus, there are several ready-made images on Docker Hub so you can get started
		right away:
		<ul>
		  <li><a href="https://registry.hub.docker.com/u/chapdev/chaperone-baseimage/">chaperone-baseimage</a>:
		    A minimal base image which establishes a startup-framework for userspace and production
		    development.  All other images are derivatives of this image.</li>
		  <li><a href="https://registry.hub.docker.com/u/chapdev/chaperone-lamp/">chaperone-lamp</a>:
		    A LAMP image (Apache, MySQL, and PHP) with <tt>phpmyadmin</tt> installed.
		  <li><a href="https://registry.hub.docker.com/u/chapdev/chaperone-lemp/">chaperone-lemp</a>:
		    A LEMP image (Nginx, MySQL, and PHP) with <tt>phpmyadmin</tt> installed.
		  <li><a href="https://registry.hub.docker.com/u/chapdev/chaperone-apache/">chaperone-apache</a>:
		    A bare-bones Apache-only image.
		</ul>
	      </div>

	      <h2 class="wsite-content-title" style="text-align:left;">And Docker ...</h2>

	      <div class="paragraph" style="text-align:left;">
		Here are some other relevant links and alternatives to <tt>chaperone</tt> that may interest you:
		<ul>
		  <li><a href="http://docker.com">docker.com</a> (of course)</li>
		  <li><a href="https://docs.docker.com/articles/using_supervisord/">Using Supervisor with Docker</a>
		    is an alternative process management approach.</li>
		</ul>
	      </div>

	    </div>

	  </div><!-- end container -->
	</div><!-- end main-wrap -->

	<div id="footer-wrap">
	  <div class="container">
	  </div><!-- end container -->
	</div><!-- end footer-wrap -->

      </div>
    </div>      
  </body>
</html>
