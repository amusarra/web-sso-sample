/*
 * #%L
 * Example SSO SAMLv2 Web Application
 * %%
 * Copyright (C) 2016 Antonio Musarra's Blog
 * %%
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as
 * published by the Free Software Foundation, either version 3 of the 
 * License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public 
 * License along with this program.  If not, see
 * <http://www.gnu.org/licenses/gpl-3.0.html>.
 * #L%
 */
package it.dontesta.labs.sso.web;

import it.dontesta.labs.sso.web.WebSSOServletContextEventListener;

import org.apache.axiom.om.util.Base64;
import org.apache.commons.lang.StringUtils;
import org.wso2.carbon.identity.sso.agent.SSOAgentConstants;
import org.wso2.carbon.identity.sso.agent.SSOAgentFilter;
import org.wso2.carbon.identity.sso.agent.SSOAgentRequestResolver;
import org.wso2.carbon.identity.sso.agent.saml.SAML2SSOManager;
import org.wso2.carbon.identity.sso.agent.util.SSOAgentUtils;
import org.wso2.carbon.identity.sso.agent.bean.SSOAgentConfig;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;
import java.util.Properties;

@WebFilter(
  filterName = "WebSSOAgentFilter",
  urlPatterns = {"/samlsso", "/logout", "/slo", "*.jsp"}
)
public class WebSSOAgentFilter extends SSOAgentFilter {

    private static Logger _log = LoggerFactory.getLogger(WebSSOAgentFilter.class);

    private static final String USERNAME = "username";
    private static final String PASSWORD = "password";
    private static final String CHARACTER_ENCODING = "UTF-8";
    private static Properties properties;
    protected FilterConfig filterConfig = null;

    static{
        properties = WebSSOServletContextEventListener.getProperties();
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse,
                         FilterChain filterChain) throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        String httpBinding = servletRequest.getParameter(
                SSOAgentConstants.SSOAgentConfig.SAML2.HTTP_BINDING);
        _log.debug(SSOAgentConstants.SSOAgentConfig.SAML2.HTTP_BINDING
          + ":" + httpBinding);
        if(httpBinding != null && !httpBinding.isEmpty()){
            if("HTTP-POST".equals(httpBinding)){
                httpBinding = "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST";
            } else if ("HTTP-Redirect".equals(httpBinding)) {
                httpBinding = "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect";
            } else {
                _log.debug("Unknown SAML2 HTTP Binding. Defaulting to HTTP-POST");
                httpBinding = "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST";
            }
        } else {
            _log.debug("SAML2 HTTP Binding not found in request. Defaulting to HTTP-POST");
            httpBinding = "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST";
        }
        SSOAgentConfig config = (SSOAgentConfig)filterConfig.getServletContext().
                getAttribute(SSOAgentConstants.CONFIG_BEAN_NAME);
        config.getSAML2().setHttpBinding(httpBinding);
        config.getOpenId().setClaimedId(servletRequest.getParameter(
                SSOAgentConstants.SSOAgentConfig.OpenID.CLAIMED_ID));
        config.getOpenId().setMode(servletRequest.getParameter(
                SSOAgentConstants.OpenID.OPENID_MODE));

        config.getSAML2().setIdPURL(properties.getProperty(SSOAgentConstants.SSOAgentConfig.SAML2.IDP_URL));

        SSOAgentRequestResolver resolver =
                            new SSOAgentRequestResolver(request, response, config);

        if (StringUtils.isNotEmpty(servletRequest.getParameter(USERNAME)) &&
                StringUtils.isNotEmpty(servletRequest.getParameter(PASSWORD))) {

            String authorization = servletRequest.getParameter(USERNAME) + ":" + servletRequest.getParameter(PASSWORD);
            // Base64 encoded username:password value
            authorization = new String(Base64.encode(authorization.getBytes(CHARACTER_ENCODING)));
            String htmlPayload = "<html>\n" +
                    "<body>\n" +
                    "<p>You are now redirected back to " + properties.getProperty("SAML2.IdPURL") + " \n" +
                    "If the redirection fails, please click the post button.</p>\n" +
                    "<form method='post' action='" +  properties.getProperty("SAML2.IdPURL") + "'>\n" +
                    "<input type='hidden' name='sectoken' value='" + authorization + "'/>\n" +
                    "<p>\n" +
                    "<!--$saml_params-->\n" +
                    "<button type='submit'>POST</button>\n" +
                    "</p>\n" +
                    "</form>\n" +
                    "<script type='text/javascript'>\n" +
                    "document.forms[0].submit();\n" +
                    "</script>\n" +
                    "</body>\n" +
                    "</html>";
            config.getSAML2().setPostBindingRequestHTMLPayload(htmlPayload);
        } else if (request.getRequestURI().endsWith("/logout") || request.getRequestURI().endsWith("/slo")) {
                _log.debug("request.getRequestURI() => " + request.getRequestURI());
                SAML2SSOManager samlSSOManager = new SAML2SSOManager(config);
                config.getSAML2().setIdPURL(config.getSAML2().getSLOURL());

                if (resolver.isHttpPostBinding()) {
                    config.getSAML2().setPassiveAuthn(false);
                    String htmlPayload = samlSSOManager.buildPostRequest(request, response, true);
                    SSOAgentUtils.sendPostResponse(request, response, htmlPayload);
                } else {
                    config.getSAML2().setPassiveAuthn(false);
                    response.sendRedirect(samlSSOManager.buildRedirectRequest(request, true));
                }
                return;
        } else {
            // Reset previously sent HTML payload
            config.getSAML2().setPostBindingRequestHTMLPayload(null);
        }
        servletRequest.setAttribute(SSOAgentConstants.CONFIG_BEAN_NAME,config);
        super.doFilter(servletRequest, servletResponse, filterChain);
    }

    @Override
    public void destroy() {
    }
}
