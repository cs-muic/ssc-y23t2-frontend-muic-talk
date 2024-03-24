package io.muzoo.ssc.project.backend.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AuthenticationController {

    @GetMapping("/api/test")
    public String test() {
        return "If this message is shown it meanss login is successful because we didnt set to permit this path";
    }

    @PostMapping("/api/login")
    public String login(HttpServletRequest request) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        try{
            request.login(username, password);
            return "successfuly login";
        } catch (ServletException e) {
            return "fail to login";
        }


    }

    @PostMapping("/api/logout")
    public String logout(HttpServletRequest request) {
       try{
           request.logout();
           return "successfuly logout";
       } catch (ServletException e){
           return "fail to logout";
       }

    }

}
