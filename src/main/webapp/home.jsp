<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="org.wso2.carbon.identity.sso.agent.bean.LoggedInSessionBean" %>
<%@ page import="org.wso2.carbon.identity.sso.agent.bean.SSOAgentConfig" %>
<%@ page import="org.wso2.carbon.identity.sso.agent.SSOAgentConstants" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
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
      <link href="css/docs.min.css" rel="stylesheet">
      <link href="css/custom.min.css" rel="stylesheet">
      <link href="css/sticky-footer-navbar.css" rel="stylesheet">
      <link href="css/app-custom.css" rel="stylesheet">
      <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
      <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
      <![endif]-->
   </head>
<%
    String claimedId = null;
    String subjectId = null;
    Map<String, String> saml2SSOAttributes = null;
    if(request.getSession(false) != null &&
            request.getSession(false).getAttribute(SSOAgentConstants.SESSION_BEAN_NAME) == null){
        request.getSession().invalidate();
%>
        <script type="text/javascript">
          location.href = "index.jsp";
        </script>
<%
        return;
    }

    SSOAgentConfig ssoAgentConfig = (SSOAgentConfig)getServletContext().getAttribute(SSOAgentConstants.CONFIG_BEAN_NAME);
    LoggedInSessionBean sessionBean = (LoggedInSessionBean)session.getAttribute(SSOAgentConstants.SESSION_BEAN_NAME);
    LoggedInSessionBean.AccessTokenResponseBean accessTokenResponseBean = null;
    String firstName = "";
    String lastName = "";

    if(sessionBean != null){
        if(sessionBean.getSAML2SSO() != null) {
            subjectId = sessionBean.getSAML2SSO().getSubjectId();
            saml2SSOAttributes = sessionBean.getSAML2SSO().getSubjectAttributes();
            if(saml2SSOAttributes != null) {
                firstName = saml2SSOAttributes.get("urn:liferay:user:firstName");
                lastName = saml2SSOAttributes.get("urn:liferay:user:lastName");
            }
            accessTokenResponseBean = sessionBean.getSAML2SSO().getAccessTokenResponseBean();
        } else {
%>
            <script type="text/javascript">
                location.href = "index.jsp";
            </script>
<%
            return;
        }
    } else {
%>
        <script type="text/javascript">
            location.href = "index.jsp";
        </script>
<%
        return;
    }
%>
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
            <ul class="nav navbar-nav navbar-right">
              <li class="dropdown">
                 <a href="#" class="dropdown-toggle" data-toggle="dropdown">Benvenuto <%=firstName%> <%=lastName%> <img src="https://media.licdn.com/mpr/mpr/shrink_100_100/AAEAAQAAAAAAAAbjAAAAJGEzNWRjZmZhLTFlMzgtNGYyYy1hY2MzLTMwMTJiZDFmNTA5Nw.jpg" alt="..." class="img-rounded"> <b class="caret"></b></a>
                 <ul class="dropdown-menu">
                    <li><a href="#myprofile"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> Il mio profilo</a></li>
                    <li><a href="#mymessage"><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span> I miei messaggi <span class="badge">4</span></a></li>
                    <li role="separator" class="divider"></li>
                    <li><a href="logout?SAML2.HTTPBinding=HTTP-Redirect"><span class="glyphicon glyphicon-hand-right" aria-hidden="true"></span> Logout (Redirect Binding)</a></li>
                    <li><a href="logout?SAML2.HTTPBinding=HTTP-POST"><span class="glyphicon glyphicon-hand-right" aria-hidden="true"></span> Logout (Post Binding)</a></li>
                 </ul>
              </li>
          </ul>
         </div>
         <!--/.nav-collapse -->
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
         <li><a href="#home" data-toggle="tab">Home</a></li>
         <li class="active"><a href="#mysamlv2data" data-toggle="tab">My SAMLv2 Data</a></li>
         <li class="disabled"><a href="#formlogin">Form Login Method</a></li>
         <li class="disabled"><a href="#redirectbinding">Redirect Binding</a></li>
         <li class="disabled"><a href="#postbinding">Post Binding</a></li>
         <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
            Other Action <span class="caret"></span>
            </a>
            <ul class="dropdown-menu">
               <li><a href="#dropdown1" data-toggle="tab">Liferay Portal Docs</a></li>
               <li><a href="#dropdown2" data-toggle="tab">WSO2 Identity Server Docs</a></li>
            </ul>
         </li>
      </ul>
      <div id="myTabContent" class="tab-content">
         <div class="tab-pane fade" id="home">
           <%@ include file="partials/tab-home.jspf" %>
         </div>
         <div class="tab-pane fade" id="dropdown1">
           <%@ include file="partials/tab-liferaydocs.jspf" %>
         </div>
         <div class="tab-pane fade" id="dropdown2">
           <%@ include file="partials/tab-wso2identity.jspf" %>
         </div>
         <div class="tab-pane fade active in" id="mysamlv2data">
           <%@ include file="partials/tab-mysamlv2data.jspf" %>
         </div>
      </div>
   </div>
   <footer class="bs-docs-footer">
     <%@ include file="partials/common-footer.jspf" %>
   </footer>
   <%@ include file="partials/common-bottom-js.jspf" %>
</body>
</html>
