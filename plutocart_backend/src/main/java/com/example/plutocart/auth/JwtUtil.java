package com.example.plutocart.auth;

import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.Date;

@Service
public class JwtUtil {
    private static final String SECRET_KEY = "ENU6NL2lgBpvquSvH4C+RX70A97I1diSyeCfxIi+Ys8hoUEkJOBP8N8lAi8/+Vdt";
    private static final long EXPIRATION_TIME = 30L * 365L * 24L * 60L * 60L * 1000L;


    public static String generateToken(String username) {
        return Jwts.builder()
                .setSubject(username)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
                .signWith(SignatureAlgorithm.HS256, SECRET_KEY)
                .compact();
    }

    public static String extractUsername(String token) {
        String tokenRemoveBearer = token.substring(7);
        if(isExpiration(tokenRemoveBearer)){
            try {
                String userId = Jwts.parserBuilder().setSigningKey(SECRET_KEY).build().parseClaimsJws(tokenRemoveBearer).getBody().getSubject();
                return userId;
            } catch (JwtException e) {
                e.printStackTrace();
                return null;
            }
        }
        else{
            throw new ResponseStatusException(HttpStatus.FORBIDDEN);
        }

    }

    public static boolean isExpiration(String token){
        Date expirationDate = Jwts.parserBuilder().setSigningKey(SECRET_KEY).build().parseClaimsJws(token).getBody().getExpiration();
        System.out.println("check expirationDate : " + expirationDate);
        if(expirationDate != null && expirationDate.before(new Date())){
            return  false;
        }
        else {
            return true;
        }

    }
}
