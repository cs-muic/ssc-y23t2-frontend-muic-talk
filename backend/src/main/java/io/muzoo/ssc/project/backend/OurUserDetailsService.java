package io.muzoo.ssc.project.backend;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class OurUserDetailsService implements UserDetailsService {
    private final PasswordEncoder passwordEncoder;

    public OurUserDetailsService(PasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }


    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        if ("admin".equals(username)) {
            String encodedPassword = passwordEncoder.encode("123456");

            return User.builder()
                    .username("admin")
                    .password(encodedPassword)
                    .roles("USER")
                    .build();
        } else {
            throw new UsernameNotFoundException("Invalid username or password");
        }
    }

}
