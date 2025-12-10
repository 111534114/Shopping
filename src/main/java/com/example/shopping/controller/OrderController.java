package com.example.shopping.controller;

import com.example.shopping.model.Order;
import com.example.shopping.service.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/egg")
@RequiredArgsConstructor
public class OrderController {

    private final OrderService orderService;

    @GetMapping("/hatch")
    public String viewOrders(Model model) {
        List<Order> orders = orderService.getAllOrders();
        model.addAttribute("orders", orders);
        return "orders";
    }
}
