package com.example.repos;
import com.example.domain.Ad;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface AdRepo extends CrudRepository<Ad, Long> {
    List<Ad> findByTag(String tag);

    Ad findAdById(Integer id);


}
