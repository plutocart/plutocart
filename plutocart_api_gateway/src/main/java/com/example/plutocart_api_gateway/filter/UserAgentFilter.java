package com.example.plutocart_api_gateway.filter;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.gateway.filter.GatewayFilter;
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;

@Component
public class UserAgentFilter extends AbstractGatewayFilterFactory<UserAgentFilter.Config> {

    @Value("${HEADER_KEY}")
    private String headerKey;
    @Value("${VALUE_HEADER}")
    private String headerValue;
    public UserAgentFilter() {
        super(Config.class);
    }
    @Override
    public GatewayFilter apply(Config config) {
        return (exchange, chain) -> {
            String userAgent = exchange.getRequest().getHeaders().getFirst(headerKey);
            if (userAgent != null && userAgent.contains(headerValue)) {
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
