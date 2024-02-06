package com.example.plutocart_api_gateway.filter;

import com.example.plutocart_api_gateway.model.HeaderModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.gateway.filter.GatewayFilter;
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;

@Component
public class UserAgentFilter extends AbstractGatewayFilterFactory<UserAgentFilter.Config> {
    public UserAgentFilter() {
        super(Config.class);
    }
    @Autowired
    HeaderModel headerModel;
    @Override
    public GatewayFilter apply(Config config) {
        return (exchange, chain) -> {
            String userAgent = exchange.getRequest().getHeaders().getFirst(headerModel.headerKey);
            if (userAgent != null && userAgent.contains(headerModel.headerValue)) {
                return chain.filter(exchange);
            } else {
                exchange.getResponse().setStatusCode(HttpStatus.UNAUTHORIZED);
                return exchange.getResponse().setComplete();
            }
        };
    }

    public static class Config {
        private String allowedUserAgent;

        public String getAllowedUserAgent() {
            return allowedUserAgent;
        }

        public void setAllowedUserAgent(String allowedUserAgent) {
            this.allowedUserAgent = allowedUserAgent;
        }
    }
}
