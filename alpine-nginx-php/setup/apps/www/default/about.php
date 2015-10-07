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
		    <li id="active" class="wsite-menu-item-wrap">
		      <a href="about.php" class="wsite-menu-item">
			About Chaperone
		      </a>
		    </li>
		    <li class="wsite-menu-item-wrap">
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

	<div id="banner-wrap" class="wsite-background">
	  <div class="container">
	    <div id="banner">
	      
	      <div id="banner-insert">
		<img style="height:250px;vertical-align:middle;align:right" src="images/chaplogo-150627.svg"/>
	      </div>
	      
	      <div id="bannerright" class="landing-banner-outer">
		<div class="landing-banner-mid">
		  <div class="landing-banner-inner">
		    <h2><span class="wsite-text wsite-headline">
			Simple Process Management
		    </span></h2>
		    <p><span class="wsite-text wsite-headline-paragraph">
			Chaperone is a lean, single-process "caretaker" for one or more processes
			inside your container.  It's designed to eliminate the need for heavier
			solutions like <tt>systemd</tt> or <tt>supervisord</tt>, and yet
			provide everything a small, focused container needs like log management,
			dependency-based start-up and lots more.
			<br/><br/>
			It's on <tt>github</tt>, of course, and there is full documentation
			available if you visit 
			<a href="https://github.com/garywiz/chaperone">https://github.com/garywiz/chaperone</a>.
		    </span></p>
		  </div><!-- end banner inner -->
		</div><!-- end banner mid -->
	      </div><!-- end banner-right -->
	      
	      <div style="clear:both;"></div>
	      
	    </div><!-- end banner -->
	  </div><!-- end container -->
	</div><!-- end banner-wrap -->
	
	<div id="footer-wrap">
	  <div class="container">
	    See the <a href="resources.php">Resources</a> page for more information.
	  </div><!-- end container -->
	</div><!-- end footer-wrap -->

      </div>
    </div>      
  </body>
</html>
