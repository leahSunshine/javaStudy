package cn.study.jwt;


import org.junit.Test;

import io.jsonwebtoken.Claims;


/**
 * Created by lonel on 2017/5/3.
 */
public class TestJwtUtil {
//    eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJqd3QiLCJpYXQiOjE0OTM4MDU5NDIsInN1YiI6IntcInJvbGVJZFwiOjEsXCJ1c2VySWRcIjoxMDAwMX0iLCJleHAiOjE0OTM4MDU5NjJ9.vtFppRcuvOaPZfx8LQhUkA0KbkDmA0J1KECvfbEKTjc
//    eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJqd3QiLCJpYXQiOjE0OTM4MDU5NDQsInN1YiI6IntcInJvbGVJZFwiOjEsXCJ1c2VySWRcIjoxMDAwMX0iLCJleHAiOjE0OTM4MDYwMDR9.8M9OT8bA53rGPFQqs_UJMhw-jLsncYasiSptniL7-MU

    @Test
    public void testGeneralKey() throws Exception {
        JwtUtil jwt = new JwtUtil();
        User user = new User();
        user.setUserId(10001L);
        user.setRoleId(1L);
        String subject = JwtUtil.generalSubject(user);
        String token = jwt.createJWT(Constant.JWT_ID, subject, Constant.JWT_TTL);
        String refreshToken = jwt.createJWT(Constant.JWT_ID, subject, Constant.JWT_REFRESH_TTL);
        System.out.println(token);
        System.out.println(refreshToken);
    }

    @Test
    public void testParseJWT() throws Exception {
        JwtUtil jwt = new JwtUtil();
        Claims claims = jwt.parseJWT("eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJqd3QiLCJpYXQiOjE0OTM4MDU5NDQsInN1YiI6IntcInJvbGVJZFwiOjEsXCJ1c2VySWRcIjoxMDAwMX0iLCJleHAiOjE0OTM4MDYwMDR9.8M9OT8bA53rGPFQqs_UJMhw-jLsncYasiSptniL7-MU");
        System.out.println(claims.getSubject());
    }
    
}
