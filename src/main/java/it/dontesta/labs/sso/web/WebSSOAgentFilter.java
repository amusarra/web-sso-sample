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

import java.io.IOException;
import java.nio.charset.Charset;
import java.util.Properties;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.axiom.om.util.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.wso2.carbon.identity.sso.agent.SSOAgentConstants;
import org.wso2.carbon.identity.sso.agent.SSOAgentFilter;
import org.wso2.carbon.identity.sso.agent.SSOAgentRequestResolver;
import org.wso2.carbon.identity.sso.agent.bean.SSOAgentConfig;

@WebFilter(filterName = "WebSSOAgentFilter", urlPatterns = { "/samlsso",
		"/logout", "/slo", "*.jsp", "*.jspf" })
public class WebSSOAgentFilter extends SSOAgentFilter {

	private static Logger _log = LoggerFactory
			.getLogger(WebSSOAgentFilter.class);

	private static final String USERNAME = "username";
	private static final String PASSWORD = "password";
	private static final String CHARACTER_ENCODING = "UTF-8";
	private static Properties properties;
	protected FilterConfig filterConfig = null;

	static {
		properties = WebSSOServletContextEventListener.getProperties();
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
	}

	@Override
	public void doFilter(ServletRequest servletRequest,
			ServletResponse servletResponse, FilterChain filterChain)
			throws IOException, ServletException {

		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;

		String httpBinding = servletRequest
				.getParameter(SSOAgentConstants.SSOAgentConfig.SAML2.HTTP_BINDING);
		_log.debug(SSOAgentConstants.SSOAgentConfig.SAML2.HTTP_BINDING + ":"
				+ httpBinding);
		if (httpBinding != null && !httpBinding.isEmpty()) {
			if ("HTTP-POST".equals(httpBinding)) {
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

		SSOAgentConfig ssoAgentConfig = (SSOAgentConfig) filterConfig
				.getServletContext().getAttribute(
						SSOAgentConstants.CONFIG_BEAN_NAME);

		ssoAgentConfig.getSAML2().setHttpBinding(httpBinding);
		ssoAgentConfig
				.getSAML2()
				.setIdPURL(
						properties
								.getProperty(SSOAgentConstants.SSOAgentConfig.SAML2.IDP_URL));

		SSOAgentRequestResolver resolver = new SSOAgentRequestResolver(request,
				response, ssoAgentConfig);

		// Reset previously sent HTML payload
		ssoAgentConfig.getSAML2().setPostBindingRequestHTMLPayload(null);

		if (_log.isDebugEnabled()) {
			String saml2SSOResponse = request
					.getParameter(SSOAgentConstants.SAML2SSO.HTTP_POST_PARAM_SAML2_RESP);
			String saml2SSORequest = request
					.getParameter(SSOAgentConstants.SAML2SSO.HTTP_POST_PARAM_SAML2_AUTH_REQ);

			if (saml2SSOResponse != null && !saml2SSOResponse.isEmpty()) {
				_log.debug(SSOAgentConstants.SAML2SSO.HTTP_POST_PARAM_SAML2_RESP
						+ "=> " + saml2SSOResponse);

				String decodedResponse = new String(
						Base64.decode(saml2SSOResponse),
						Charset.forName("UTF-8"));

				_log.debug("Decoded "
						+ SSOAgentConstants.SAML2SSO.HTTP_POST_PARAM_SAML2_RESP
						+ "=> " + decodedResponse);
			}

			if (saml2SSORequest != null && !saml2SSORequest.isEmpty()) {
				_log.debug(SSOAgentConstants.SAML2SSO.HTTP_POST_PARAM_SAML2_AUTH_REQ
						+ "=> " + saml2SSORequest);

				String decodedResponse = new String(
						Base64.decode(saml2SSORequest),
						Charset.forName("UTF-8"));

				_log.debug("Decoded "
						+ SSOAgentConstants.SAML2SSO.HTTP_POST_PARAM_SAML2_AUTH_REQ
						+ "=> " + decodedResponse);
			}

		}

		if (request.getRequestURI().endsWith("/logout") && resolver.isSLOURL()) {
			ssoAgentConfig.getSAML2().setIdPURL(
					properties.getProperty("SAML2.IdPSLOURL"));
		}

		servletRequest.setAttribute(SSOAgentConstants.CONFIG_BEAN_NAME,
				ssoAgentConfig);
		super.doFilter(servletRequest, servletResponse, filterChain);
	}

	@Override
	public void destroy() {
	}
}
