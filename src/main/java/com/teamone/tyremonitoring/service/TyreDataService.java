package com.teamone.tyremonitoring.service;

import com.teamone.tyremonitoring.model.TyreData;
import com.teamone.tyremonitoring.repository.TyreDataRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TyreDataService {

    @Autowired
    private TyreDataRepository tyreDataRepository;

    public TyreData saveTyreData(TyreData tyreData) {
        return tyreDataRepository.save(tyreData);
    }

    public List<TyreData> getAllTyreData() {
        return tyreDataRepository.findAll();
    }
}