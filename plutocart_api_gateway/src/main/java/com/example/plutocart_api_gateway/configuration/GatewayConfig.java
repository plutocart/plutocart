package com.example.plutocart_api_gateway.configuration;
import com.example.plutocart_api_gateway.filter.UserAgentFilter;
import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class GatewayConfig {

    @Bean
    public RouteLocator customRouteLocator(RouteLocatorBuilder builder, UserAgentFilter userAgentFilter) {
        return builder.routes()
                .route("api_route", r -> r.path("/api/**")
                        .filters(f -> f.filter(userAgentFilter.apply(new UserAgentFilter.Config())))
                        .uri("http://backend:8080"))
                .build();
    }

//    @Bean
//    public RouteLocator customRouteLocator(RouteLocatorBuilder builder) {
//        return builder.routes()
//                .route("api_route", r -> r.path("/api/**")
//                        .filters(GatewayFilterSpec::secureHeaders)
//                        .uri("http://backend:8080"))
//                .build();
//    }

//    @Bean
//    public RouteLocator customRouteLocator(RouteLocatorBuilder builder) {
//        return builder.routes()
//                .route("api_route", r -> r.path("/api/**")
//                        .filters(GatewayFilterSpec::secureHeaders)
//                        .uri("http://localhost:8080"))
//                .build();
//    }
//}
}
