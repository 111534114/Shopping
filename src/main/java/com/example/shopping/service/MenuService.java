package com.example.shopping.service;

import com.example.shopping.model.MenuItem;

import com.example.shopping.repository.MenuItemRepository;

import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;



import java.util.List;
import java.util.Optional;

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

    public Optional<MenuItem> getMenuItemById(Integer id) {
        return menuItemRepository.findById(id);
    }

    public MenuItem addMenuItem(MenuItem menuItem) {
        // In a real app, you'd add validation here
        return menuItemRepository.save(menuItem);
    }

    public MenuItem updateMenuItem(Integer id, MenuItem menuItemDetails) {
        MenuItem existingItem = menuItemRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Menu item not found with id: " + id));

        existingItem.setName(menuItemDetails.getName());
        existingItem.setDescription(menuItemDetails.getDescription());
        existingItem.setPrice(menuItemDetails.getPrice());
        existingItem.setCategory(menuItemDetails.getCategory());
        existingItem.setImageUrl(menuItemDetails.getImageUrl());
        existingItem.setAvailable(menuItemDetails.isAvailable());

        return menuItemRepository.save(existingItem);
    }

    public void deleteMenuItem(Integer id) {
        if (!menuItemRepository.existsById(id)) {
            throw new IllegalArgumentException("Menu item not found with id: " + id);
        }
        menuItemRepository.deleteById(id);
    }
}
