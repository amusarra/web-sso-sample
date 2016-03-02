<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.wso2.carbon.identity.sso.agent.bean.SSOAgentConfig" %>
<%@ page import="org.wso2.carbon.identity.sso.agent.SSOAgentConstants" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="Example SSO SAMLv2 Web Application by WSO2 Identity Components">
    <meta name="author" content="Antonio Musarra">
      <meta name="robots" content="All" />
      	<meta name="keywords" content="SAML, SAMLv2, WSO2, SSO, WebSSO, SSOAgent" />
      	<meta name="generator" content="META Tag Generator: http://toolswebtop.com/seo/metatag" />
      	<meta name="rating" content="General" />
      	<meta name="dcterms.title" content="Welcome to Example SSO SAMLv2 Web Application by WSO2 Identity Components" />
      	<meta name="dcterms.contributor" content="Antonio Musarra" />
      	<meta name="dcterms.creator" content="Antonio Musarra" />
      	<meta name="dcterms.publisher" content="Antonio Musarra" />
      	<meta name="dcterms.description" content="In this portal are published all or most of the projects developed specifically for the articles I write on the Antonio Musarra's Blog." />
      	<meta name="dcterms.rights" content="Antonio Musarra's Blog" />
      	<meta property="og:type" content="website" />
      	<meta property="og:title" content="Welcome to Example SSO SAMLv2 Web Application by WSO2 Identity Components" />
      	<meta property="og:description" content="In this portal are published all or most of the projects developed specifically for the articles I write on the Antonio Musarra's Blog." />
      	<meta property="twitter:title" content="Welcome to Antonio Musarra's Blog OpenShift" />
      	<meta property="twitter:description" content="In this portal are published all or most of the projects developed specifically for the articles I write on the Antonio Musarra's Blog." />
          <meta name="twitter:card" content="summary" />
          <meta name="twitter:site" content="@antonio_musarra" />
          <meta name="twitter:domain" content=" Antonio Musarra&#039;s Blog" />
          <meta name="twitter:creator" content="@antonio_musarra" />
    <title>Example SSO SAMLv2 Web Application by WSO2 Identity Components</title>

    <link rel="author" href="https://plus.google.com/u/0/106632657524115981454/about/p/pub" />
        <link rel="publisher" href="https://plus.google.com/u/0/106632657524115981454/about/p/pub" />

    <!-- Bootstrap core CSS -->
    <link rel='stylesheet' href='<%= org.webjars.AssetLocator.getWebJarPath("css/bootstrap.min.css") %>'>

    <!-- Optional fonts -->
    <link rel="stylesheet" href='<%= org.webjars.AssetLocator.getWebJarPath("css/font-awesome.min.css") %>'>

    <!-- Custom styles for this template -->
    <link href="css/bootswatch-bootstrap-united.min.css" rel="stylesheet">
    <link href="css/custom.min.css" rel="stylesheet">
    <link href="css/sticky-footer-navbar.css" rel="stylesheet">
    <link href="css/app-custom.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
  <!-- Fixed navbar -->
  <nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="#"><strong>SSO SAMLv2 Web Application</strong></a>
      </div>
      <div id="navbar" class="collapse navbar-collapse">
        <ul class="nav navbar-nav">
                    <li class="active"><a href="#">Home</a></li>
                    <li><a href="http://www.dontesta.it/blog/">Blog</a></li>
                    <li><a href="http://www.dontesta.it/blog/amusarra/">About</a></li>
                    <li><a href="http://www.dontesta.it/blog/contatti/">Contact</a></li>
                    <li class="dropdown">
                      <a href="#" class="dropdown-toggle" data-toggle="dropdown">Active Projects <b class="caret"></b></a>
                      <ul class="dropdown-menu">
                        <li class="dropdown-header">Web Services</li>
                        <li><a href="example-cxf-rs-services-1.0-SNAPSHOT/">Simple CXF JAX-RS WebApp Service</a></li>
                        <li><a href="HTMLSugarCRMRESTApplication.html">SugarCRM REST API application</a></li>
                      </ul>
                    </li>
                  </ul>
        </div><!--/.nav-collapse -->
    </div>
  </nav>

  <!-- Begin page content -->
  <div class="container">
    <div class="page-header">
      <h1>Welcome to SSO SAMLv2 Web Application</h1>
    </div>
    <p class="text-justify">
      <img style="float:left; padding: 5px;" src="images/samlXMLorg-logo.png" class="img-responsive" alt="Responsive image">
      Security Assertion Markup Language (SAML) is an XML-based solution for exchanging user security information between an
      enterprise and a service provider. It supports W3C XML encryption and service provider initiated web browser single sign-on exchanges.
      A user wielding a user agent (usually a web browser) is called the subject in the SAML-based single sign-on.
      The user requests a web resource protected by a SAML service provider. The service provider, wishing to know the
      identity of the requesting user, issues an authentication request to a SAML identity provider through the user agent.
      The identity provider is the one that provides the user credentials. The service provider trusts the identity provider
      of the user information, to provide access to its services or resources.
    </p>
    <ul class="nav nav-tabs">
      <li class="active"><a href="#home" data-toggle="tab">Home</a></li>
      <li><a href="#formlogin" data-toggle="tab">Form Login Method</a></li>
      <li><a href="#redirectbinding" data-toggle="tab">Redirect Binding</a></li>
      <li><a href="#postbinding" data-toggle="tab">Post Binding</a></li>
      <li class="dropdown">
        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
          Other Action <span class="caret"></span>
        </a>
        <ul class="dropdown-menu">
          <li><a href="#dropdown1" data-toggle="tab">Liferay idP Portal</a></li>
          <li><a href="#dropdown2" data-toggle="tab">Liferay SAML Docs</a></li>
          <li><a href="#dropdown3" data-toggle="tab">WSO2 Identity Server Docs</a></li>
        </ul>
      </li>
    </ul>
    <div id="myTabContent" class="tab-content">
      <div class="tab-pane fade active in" id="home">
        <p>Raw denim you probably haven't heard of them jean shorts Austin. Nesciunt tofu stumptown aliqua, retro synth master cleanse. Mustache cliche tempor, williamsburg carles vegan helvetica. Reprehenderit butcher retro keffiyeh dreamcatcher synth. Cosby sweater eu banh mi, qui irure terry richardson ex squid. Aliquip placeat salvia cillum iphone. Seitan aliquip quis cardigan american apparel, butcher voluptate nisi qui.</p>
      </div>
      <div class="tab-pane fade" id="formlogin">
        <div class="well bs-component">
          <form class="form-horizontal" role="form" data-toggle="validator" method="post" action="samlsso?SAML2.HTTPBinding=HTTP-POST">
            <fieldset>
              <legend>Login with SAMLv2 (Post Binding) from Liferay Identity Provider with user credentials</legend>
              <div class="form-group has-feedback">
                <label for="inputEmail" class="col-lg-2 control-label">Email</label>
                <div class="col-lg-10">
                  <input type="email" class="form-control" id="username" placeholder="Email" autocomplete="off" aria-describedby="inputSuccessEmailStatus" required>
                  <span class="glyphicon form-control-feedback" aria-hidden="true"></span>
                  <span id="inputSuccessEmailStatus" class="sr-only">(success)</span>
                  <div class="help-block with-errors"></div>
                </div>
              </div>
              <div class="form-group has-feedback">
                <label for="inputPassword" class="col-lg-2 control-label">Password</label>
                <div class="col-lg-10">
                  <input type="password"  class="form-control" id="password" data-minlength="4" placeholder="Password" autocomplete="off" aria-describedby="inputSuccessPasswordStatus" required>
                  <span class="glyphicon form-control-feedback" aria-hidden="true"></span>
                  <span id="inputSuccessPasswordStatus" class="sr-only">(success)</span>
                  <div class="help-block with-errors"></div>
                </div>
              </div>
              <div class="form-group">
                <div class="col-lg-10 col-lg-offset-2">
                  <button type="reset" class="btn btn-default">Cancel</button>
                  <button type="submit" class="btn btn-primary">Submit</button>
                </div>
              </div>
            </fieldset>
          </form>
        </div>
      </div>
      <div class="tab-pane fade" id="redirectbinding">
        <p class="lead">Click <a href="samlsso?SAML2.HTTPBinding=HTTP-Redirect">here</a> to login with SAMLv2 (Redirect binding) from Liferay Identity Provider</p>
      </div>
      <div class="tab-pane fade" id="postbinding">
        <p class="lead">Click <a href="samlsso?SAML2.HTTPBinding=HTTP-POST">here</a> to login with (Post Binding) from Liferay Identity Provider</p>
      </div>
      <div class="tab-pane fade" id="dropdown1">
        <p>Etsy mixtape wayfarers, ethical wes anderson tofu before they sold out mcsweeney's organic lomo retro fanny pack lo-fi farm-to-table readymade. Messenger bag gentrify pitchfork tattooed craft beer, iphone skateboard locavore carles etsy salvia banksy hoodie helvetica. DIY synth PBR banksy irony. Leggings gentrify squid 8-bit cred pitchfork.</p>
      </div>
      <div class="tab-pane fade" id="dropdown3">
        <p>Trust fund seitan letterpress, keytar raw denim keffiyeh etsy art party before they sold out master cleanse gluten-free squid scenester freegan cosby sweater. Fanny pack portland seitan DIY, art party locavore wolf cliche high life echo park Austin. Cred vinyl keffiyeh DIY salvia PBR, banh mi before they sold out farm-to-table VHS viral locavore cosby sweater.</p>
      </div>
    </div>

  </div>

  <footer class="footer">
    <div class="container">
      <div class="row">
      					<div class="col-xs-6">
      						<a class="btn btn-social-icon btn-twitter" target="_blank"
      							title="On Twitter"
      							href="http://twitter.com/share?url=http%3A%2F%2Fjbossews-shiruslabs.rhcloud.com&text=Welcome%20to%20Antonio%20Musarra%27s%20Blog%20JBossEWS%20(Apache%2FTomcat)%20application%20on%20OpenShift">
      						<i class="fa fa-3x social-footer fa-twitter-square"></i>
      						</a> <a class="btn btn-social-icon btn-facebook" target="_blank"
      							title="On Facebook"
      							href="http://www.facebook.com/share.php?u=http%3A%2F%2Fjbossews-shiruslabs.rhcloud.com&t=Welcome%20to%20Antonio%20Musarra%27s%20Blog%20JBossEWS%20(Apache%2FTomcat)%20application%20on%20OpenShift">
      						<i class="fa fa-3x social-footer fa-facebook-square"></i>
      						</a> <a class="btn btn-social-icon btn-google-plus" target="_blank"
      							title="On Google Plus"
      							href="https://plusone.google.com/_/+1/confirm?hl=en&url=http%3A%2F%2Fjbossews-shiruslabs.rhcloud.com">
      						<i class="fa fa-3x social-footer fa-google-plus-square"></i>
      						</a> <a class="btn btn-social-icon btn-linkedin" target="_blank"
      							title="On LinkedIn"
      							href="http://www.linkedin.com/shareArticle?mini=true&url=http%3A%2F%2Fjbossews-shiruslabs.rhcloud.com">
      						<i class="fa fa-3x social-footer fa-linkedin-square"></i>
      						</a>
                  <a class="btn btn-social-icon btn-git" target="_blank"
      							title="On GitHub"
      							href="https://github.com/amusarra">
      						<i class="fa fa-3x social-footer fa-git-square"></i>
      						</a>
                  <p>Made by <a href="http://wwww.dontesta.it/blog" rel="nofollow">Antonio Musarra's Blog</a> Contact at <a href="mailto:antonio.musarra@gmail.com">antonio.musarra@gmail.com</a></p>
                  <p>Code released under the <a href="http://www.gnu.org/licenses/gpl-3.0.en.html">GPLv3 License</a>.</p>
                  <p>Based on <a href="http://getbootstrap.com" rel="nofollow">Bootstrap</a>. Icons from <a href="http://fortawesome.github.io/Font-Awesome/" rel="nofollow">Font Awesome</a>. Web fonts from <a href="http://www.google.com/webfonts" rel="nofollow">Google</a>.</p>
                  <p>&nbsp;</p>
                  <p>Antonio Musarra's Blog &copy; 2016. All Rights Reserved.</p>
      					</div>
                <div class="col-xs-6">
      						<span class="logo-wso-identity pull-right">
      							<a href="http://wso2.com/products/identity-server/"></a>
      						</span>
      					</div>
      				</div>
        </div>
  </footer>

  <script type='text/javascript' src='<%= org.webjars.AssetLocator.getWebJarPath("jquery.min.js") %>'></script>
  <script type='text/javascript' src='<%= org.webjars.AssetLocator.getWebJarPath("js/bootstrap.min.js") %>'></script>
  <script type='text/javascript' src='<%= org.webjars.AssetLocator.getWebJarPath("js/validator.js") %>'></script>
</body>
</html>
