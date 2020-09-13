package com.example.controller;

import com.example.domain.Ad;
import com.example.domain.User;
import com.example.repos.AdRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import sun.awt.image.IntegerComponentRaster;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

@Controller
public class AddController {
    @Autowired
    private AdRepo adRepo;

    @Value("${upload.path}")
    private String uploadPath;
    @GetMapping("/main")
    public String main(@RequestParam(required = false, defaultValue = "") String filter, Model model) {
        Iterable<Ad> ads = adRepo.findAll();

        if (filter != null && !filter.isEmpty()) {
            ads = adRepo.findByTag(filter);
        } else {
            ads = adRepo.findAll();
        }

        model.addAttribute("ads", ads);
        model.addAttribute("filter", filter);

        return "main";
    }

    @GetMapping("/add/{id}")
    public String getAdd(@PathVariable String id,Model model){
        Ad addFromDb = adRepo.findAdById(Integer.valueOf(id));

        model.addAttribute("add",addFromDb);

        return "add";
    }


    @PostMapping("/main")
    public String add(
            @AuthenticationPrincipal User user,
            @RequestParam String text,
            @RequestParam String tag, Map<String, Object> model,
            @RequestParam String number,
            @RequestParam("file") MultipartFile file
    ) throws IOException {
        Ad ad = new Ad(text, tag, user, number);

        if (file != null && !file.getOriginalFilename().isEmpty()) {
            File uploadDir = new File(uploadPath);

            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String uuidFile = UUID.randomUUID().toString();
            String resultFilename = uuidFile + "." + file.getOriginalFilename();

            file.transferTo(new File(uploadPath + "/" + resultFilename));

            ad.setFilename(resultFilename);
        }

        adRepo.save(ad);

        Iterable<Ad> ads = adRepo.findAll();

        model.put("ads", ads);

        return "main";
    }
}
