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
import org.wso2.carbon.identity.sso.agent.bean.SSOAgentConfig;
import org.wso2.carbon.identity.sso.agent.SSOAgentException;
import org.wso2.carbon.identity.sso.agent.saml.SSOAgentX509Credential;
import org.wso2.carbon.identity.sso.agent.saml.SSOAgentX509KeyStoreCredential;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.annotation.WebListener;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

@WebListener
public class WebSSOServletContextEventListener implements ServletContextListener {

    private static Logger _log = LoggerFactory.getLogger(WebSSOServletContextEventListener.class);

    private static Properties properties;

    public void contextInitialized(ServletContextEvent servletContextEvent) {

        properties = new Properties();
        try {
            properties.load(servletContextEvent.getServletContext().getResourceAsStream("/WEB-INF/classes/webssosample.properties"));
            InputStream keyStoreInputStream = servletContextEvent.getServletContext().
                    getResourceAsStream("/WEB-INF/classes/webssosample.jks");
            SSOAgentX509Credential credential =
                    new SSOAgentX509KeyStoreCredential(keyStoreInputStream,
                            properties.getProperty("KeyStorePassword").toCharArray(),
                            properties.getProperty("IdPPublicCertAlias"),
                            properties.getProperty("PrivateKeyAlias"),
                            properties.getProperty("PrivateKeyPassword").toCharArray());
            SSOAgentConfig config = new SSOAgentConfig();
            config.initConfig(properties);
            config.getSAML2().setSSOAgentX509Credential(credential);
            servletContextEvent.getServletContext().
                    setAttribute(SSOAgentConstants.CONFIG_BEAN_NAME, config);
        } catch (IOException e){
            _log.error(e.getMessage(), e);
        } catch (SSOAgentException e) {
            _log.error(e.getMessage(), e);
        }
    }

    public void contextDestroyed(ServletContextEvent servletContextEvent) {
    }

    /**
     * Get the properties of the sample
     * @return Properties
     */
    public static Properties getProperties(){
        return properties;
    }
}
