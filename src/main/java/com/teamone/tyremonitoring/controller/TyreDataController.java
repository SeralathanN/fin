package com.teamone.tyremonitoring.controller;

import com.teamone.tyremonitoring.model.TyreData;
import com.teamone.tyremonitoring.service.TyreDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/data")
public class TyreDataController {

    @Autowired
    private TyreDataService tyreDataService;

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    // Endpoint to receive data from Arduino
    @PostMapping
    public TyreData saveTyreData(@RequestBody TyreData tyreData) {
        TyreData savedData = tyreDataService.saveTyreData(tyreData);

        // Send real-time updates via WebSocket to the topic '/topic/tyreData'
        messagingTemplate.convertAndSend("/topic/tyreData", savedData);

        return savedData;
    }

    // Endpoint to fetch all data for frontend
    @GetMapping
    public List<TyreData> getAllTyreData() {
        return tyreDataService.getAllTyreData();
    }
}