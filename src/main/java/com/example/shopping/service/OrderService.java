package com.example.shopping.service;

import com.example.shopping.dto.OrderRequest;
import com.example.shopping.model.*;
import com.example.shopping.repository.MenuItemRepository;
import com.example.shopping.repository.OrderRepository;
import com.example.shopping.repository.UserRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderRepository orderRepository;
    private final MenuItemRepository menuItemRepository;
    private final UserRepository userRepository;
    private final PromotionService promotionService; // Inject PromotionService
    private final ObjectMapper objectMapper = new ObjectMapper(); // For converting customizations map to JSON string

    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    public Order getOrderById(Integer id) {
        return orderRepository.findById(id).orElse(null);
    }

    @Transactional
    public Order createOrder(OrderRequest orderRequest) {
        // 1. Fetch the customer
        User customer = userRepository.findById(orderRequest.customerId())
                .orElseThrow(() -> new IllegalArgumentException("Customer not found with id: " + orderRequest.customerId()));

        // 2. Create the Order entity
        Order order = new Order();
        order.setCustomer(customer);
        order.setOrderDate(Timestamp.from(Instant.now()));
        order.setStatus("pending");
        order.setNotes(orderRequest.notes());
        order.setPaymentMethod(orderRequest.paymentMethod());

        // 3. Create OrderItem entities and calculate total price
        List<OrderItem> orderItems = new ArrayList<>();
        BigDecimal totalPrice = BigDecimal.ZERO;

        for (var itemRequest : orderRequest.items()) {
            // Fetch the menu item from DB to get the correct price
            MenuItem menuItem = menuItemRepository.findById(itemRequest.menuItemId())
                    .orElseThrow(() -> new IllegalArgumentException("Menu item not found with id: " + itemRequest.menuItemId()));

            if (!menuItem.isAvailable()) {
                throw new IllegalStateException("Menu item " + menuItem.getName() + " is not available.");
            }

            OrderItem orderItem = new OrderItem();
            orderItem.setOrder(order);
            orderItem.setMenuItem(menuItem);
            orderItem.setQuantity(itemRequest.quantity());
            orderItem.setPricePerItem(menuItem.getPrice()); // Use price from DB

            try {
                orderItem.setCustomizations(objectMapper.writeValueAsString(itemRequest.customizations()));
            } catch (Exception e) {
                throw new RuntimeException("Failed to serialize customizations", e);
            }

            orderItems.add(orderItem);
            totalPrice = totalPrice.add(menuItem.getPrice().multiply(BigDecimal.valueOf(itemRequest.quantity())));
        }

        order.setOrderItems(orderItems);
        order.setTotalPrice(totalPrice);

        // 4. Save the order and its items
        Order savedOrder = orderRepository.save(order);

        // 5. Check and apply promotions
        promotionService.checkAndApplyPromotions(savedOrder);

        // 6. Return the final state of the order
        return savedOrder;
    }
}