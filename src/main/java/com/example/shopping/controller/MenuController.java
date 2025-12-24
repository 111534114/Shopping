package com.example.shopping.controller;

import com.example.shopping.model.MenuItem;
import com.example.shopping.service.MenuService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/chick")
@RequiredArgsConstructor
public class MenuController {

    private final MenuService menuService;

    @GetMapping("/menu")
    public List<MenuItem> getMenu() {
        return menuService.getAvailableMenuItems();
    }

    @GetMapping("/menu/{id}")
    public ResponseEntity<MenuItem> getMenuItem(@PathVariable("id") Integer id) {
        Optional<MenuItem> menuItem = menuService.getMenuItemById(id);
        return menuItem.map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
}
