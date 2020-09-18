package com.example.service;

import com.example.domain.Role;
import com.example.domain.User;
import com.example.repos.UserRepo;
import freemarker.template.utility.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;


@Service
public class UserService implements UserDetailsService {

    @Autowired
    private UserRepo userRepo;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return userRepo.findByUsername(username);
    }

    public List<User> findAll(){
        return userRepo.findAll();
    }


    public void saveUser(User user, String username, Map<String, String> form){
        user.setUsername(username);

        Set<String> roles = Arrays.stream(Role.values())  //В строковый вид
                .map(Role::name)
                .collect(Collectors.toSet());

        user.getRoles().clear();

        for (String key : form.keySet()) {
            if (roles.contains(key)) {
                user.getRoles().add(Role.valueOf(key));
            }
        }

        userRepo.save(user);
    }

    public void updateProfile(User user, String password, String number) {
        String userNumber = user.getNumber();

        boolean isNumberChanged = (number != null && number.equals(userNumber)) ||
                (userNumber != null && userNumber.equals(number));
        if(isNumberChanged){
            user.setNumber(number);
        }

        if(!password.isEmpty()){
            user.setPassword(password);
        }

        userRepo.save(user);
    }
}
