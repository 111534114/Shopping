package com.example.shopping.controller;

import com.example.shopping.model.MenuItem;
import com.example.shopping.service.MenuService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/chick")
@RequiredArgsConstructor
public class MenuController {

    private final MenuService menuService;

    @GetMapping("/menu")
    public String viewMenu(Model model) {
        List<MenuItem> menuItems = menuService.getAvailableMenuItems();
        model.addAttribute("menuItems", menuItems);
        return "menu";
    }
}
