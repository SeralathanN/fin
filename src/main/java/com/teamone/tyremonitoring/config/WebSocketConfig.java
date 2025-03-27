package com.teamone.tyremonitoring.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    @Override
    public void configureMessageBroker(MessageBrokerRegistry config) {
        config.enableSimpleBroker("/topic"); // In-memory message broker
        config.setApplicationDestinationPrefixes("/app"); // Prefix for client-to-server messages
    }

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        // Allowing CORS to handle requests from frontend on different domains
        registry.addEndpoint("/ws")
                .setAllowedOrigins("http://localhost", "http://127.0.0.1", "http://192.168.178.35")
                .withSockJS(); // WebSocket fallback for unsupported browsers
    }
}