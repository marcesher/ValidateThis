<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>ValidateThis! - A Validation Framework for ColdFusion Objects</title>
	<link rel="stylesheet" href="css/layout.css" type="text/css" />
	<link rel="stylesheet" href="css/style.css" type="text/css" />
</head>

<body>

<div id="wrap">
	<div id="header">			
		<h1 id="logo-text"><a href="http://www.validatethis.org" title="ValidateThis!">ValidateThis!</a></h1>		
		<p id="slogan">A Validation Framework for ColdFusion Objects</p>
		<!---
		<div id="header-links">
			<p>
			<a href="http://www.silverwareconsulting.com/contact.cfm">Contact</a> | 
			<a href="http://www.silverwareconsulting.com/rss.cfm?mode=full" rel="noindex,nofollow">RSS</a>
			</p>		
		</div>
		--->
	</div>

	<div id="content-wrap">
				
		<div id="main">
				
			<div class="entry">
				<h2>Welcome to the home of ValidateThis!</h2>
		
				<p>
					ValidateThis! is a framework that allows you to define validation rules for your ColdFusion objects in a single place (either an xml file, or in ColdFusion code) and will then generate client-side and server-side validations for you.
				</p>
				<p>Please check out one of the demos, linked to the right, to see the framework in action, as well as a sample xml file.</p>
				<p>The framework, as well as all of the demo code, can be downloaded from <a href="http://validatethis.riaforge.org/" title="validatethis.riaforge.org" target="_blank">validatethis.riaforge.org</a>.</p>
				<p>The framework itself has been designed to be extremely flexible and extensible. For example:
					<ul>
						<li>The framework ships with a wide variety of built-in validation types. It is easy to add custom validation types without having to touch any existing framework code.</li>
						<li>The framework ships with client-side validations implemented using the jQuery Validation Plugin.  It is possible to add other client-side implementations (e.g., prototype, spry, etc.) without touching any of the existing framework code.</li>
						<li>When validation failures occur the framework will return a suitable and meaningful failure message.  These default failure messages can easily be overriden by an application developer.</li>
						<li>In addition to failure messages, the framework will return metadata about the validation failure, which can be used to further customize the display of failure information to a user.  This can facilitate internationalization.</li>
						<li>The framework can be used in conjunction with any other framework (e.g., Transfer, Reactor, etc.), or no framework at all.  As long as you are using a Business Object, you can use the framework to fulfill your validation needs.</li>
					</ul>
				</p>
   
			</div>
		
		</div>
		
		<div id="sidebar">
	
			<h3>Download</h3>
	
			<p class="sidemenu">
				You can download the most recent version of ValidateThis from <a href="http://validatethis.riaforge.org/" title="validatethis.riaforge.org" target="_blank">validatethis.riaforge.org</a>.
			</p>
			
			<h3>Demos</h3>
	
			<ul class="sidemenu">				
				<li>
					<a href="/BODemo/index.cfm">Full demo using integrated Business Objects and Transfer</a>
				</li>
				<li>
					<a href="/ServiceDemo/index.cfm">Full demo using simple integration via the ValidateThis object and Reactor</a>
				</li>
				<li>
					<a href="/BODemo/index.cfm?cfU=_cfU">Full demo using integrated Business Objects, Transfer and cfUniForm</a>
				</li>
			</ul>
			
			<h3>Tutorial Sample App</h3>
	
			<ul class="sidemenu">				
				<li>
					<a href="http://www.validatethis.org/VTAndTransfer_Start/index.cfm">Inital sample app, with no validations</a>
				</li>
				<li>
					<a href="http://www.validatethis.org/VTAndTransfer_PartII/index.cfm">Sample app with server-side validations</a>
				</li>
				<li>
					<a href="http://www.validatethis.org/VTAndTransfer_PartIII/index.cfm">Sample app with client- and server-side validations</a>
				</li>
			</ul>
			
		</div>
	
	</div>
		
		
	<!-- footer starts -->		
	<div id="footer-wrap">
		<div id="footer-bottom">
			&copy; 2009 <strong>Bob Silverberg</strong> | 
			Design by: <a href="http://www.styleshout.com/">styleshout</a>
		</div>
	<!-- footer ends-->
	</div>

<!-- wrap ends here -->
</div>

</body>
</html>