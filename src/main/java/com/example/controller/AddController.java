package com.example.controller;

import com.example.domain.Ad;
import com.example.domain.User;
import com.example.repos.AdRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collector;
import java.util.stream.Collectors;

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
            @Valid Ad ad,
            BindingResult bindingResult,
            //@RequestParam String text,
            //@RequestParam String tag, Map<String, Object> model,
            Model model,
            @RequestParam String number,
            @RequestParam("file") MultipartFile file
    ) throws IOException {
        ad.setAuthor(user);

       /* if(bindingResult.hasErrors()){
            Collector<FieldError, ?, Map<String, String>> collector = Collectors.toMap(
                    fieldError -> fieldError.getField() + "Error",
                    FieldError::getDefaultMessage
            );
            Map<String, String> errosMap = bindingResult.getFieldError()stream.collect(collector);
            model.mergeAttributes(errosMap);*/
        if (bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);

            model.mergeAttributes(errorsMap);
            model.addAttribute("ad", ad);
        }else {
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

            model.addAttribute("ad", null);
            adRepo.save(ad);
        }
        Iterable<Ad> ads = adRepo.findAll();

        model.addAttribute("ads", ads);

        return "main";
    }
}
