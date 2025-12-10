package com.example.shopping.service;

import com.example.shopping.model.MenuItem;
import com.example.shopping.repository.MenuItemRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class MenuService {

    private final MenuItemRepository menuItemRepository;

    public List<MenuItem> getAvailableMenuItems() {
        return menuItemRepository.findByIsAvailableTrue();
    }

    public List<MenuItem> getAllMenuItems() {
        return menuItemRepository.findAll();
    }
}
