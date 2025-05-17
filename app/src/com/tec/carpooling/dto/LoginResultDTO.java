package com.tec.carpooling.dto;

import com.tec.carpooling.domain.entity.User;
import java.util.Set;

public class LoginResultDTO {
    private final User user;
    private final Set<String> roles; // Roles disponibles (DRIVER, PASSENGER)

    public LoginResultDTO(User user, Set<String> roles) {
        this.user = user;
        this.roles = roles;
    }

    public User getUser() {
        return user;
    }

    public Set<String> getRoles() {
        return roles;
    }

    public boolean isLoginSuccessful() {
        return user != null && roles != null && !roles.isEmpty();
    }
}