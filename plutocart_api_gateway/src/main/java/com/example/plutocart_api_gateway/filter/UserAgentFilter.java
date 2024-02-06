package com.example.plutocart_api_gateway.filter;
import org.springframework.cloud.gateway.filter.GatewayFilter;
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;

@Component
public class UserAgentFilter extends AbstractGatewayFilterFactory<UserAgentFilter.Config> {
    public UserAgentFilter() {
        super(Config.class);
    }
    @Override
    public GatewayFilter apply(Config config) {
        return (exchange, chain) -> {
            String userAgent = exchange.getRequest().getHeaders().getFirst("L3Tme6FbXkMRWy2j4J8dN7q5gxICvDZ1EaSBQrOPKfHn09hGYcuwioVszplUAT");
            if (userAgent != null && userAgent.contains("ZbXa9IuOq5BdVcPmKsWlRjHgTeYfSdFnGhJiKlMnOpQrStUvWxYzAbCdEfGhJiKlM")) {
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
