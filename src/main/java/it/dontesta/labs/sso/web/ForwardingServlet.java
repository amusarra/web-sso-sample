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

import org.wso2.carbon.identity.sso.agent.SSOAgentConstants;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.WebInitParam;

import java.io.IOException;

@WebServlet(
    name = "ForwardingServlet",
    description = "Web SSO forwarding servlet",
    loadOnStartup = 1,
    urlPatterns = {"/samlsso", "/logout", "/slo"},
    initParams = {
                @WebInitParam(name = "user", value = "test@liferay.com"),
                @WebInitParam(name = "password", value = "test")
        }
)
public class ForwardingServlet extends HttpServlet {

    private static Logger _log = LoggerFactory.getLogger(ForwardingServlet.class);

    protected  void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        if(request.getRequestURI().endsWith("/samlsso")){
            request.getRequestDispatcher("home.jsp").forward(request,response);
        } else if (request.getRequestURI().endsWith("/logout") || request.getRequestURI().endsWith("/slo")){
            request.getRequestDispatcher("index.jsp").forward(request,response);
        }
    }

}
