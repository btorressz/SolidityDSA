// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StockSpanner {
    struct PriceSpan {
        uint price;
        uint span;
    }

    PriceSpan[] public prices;

    constructor() {
        prices.push(PriceSpan({price: 0, span: 0})); // Dummy value to handle edge case for the first element
    }

    function next(uint price) public returns (uint) {
        uint span = 1; // Span is at least 1 (the current day)
        
        // Check the previous prices and sum their spans if they are less than or equal to the current price
        while (prices.length > 1 && prices[prices.length - 1].price <= price) {
            span += prices[prices.length - 1].span;
            prices.pop(); // Remove the last element
        }
        
        // Push the current price and its span
        prices.push(PriceSpan({price: price, span: span}));
        return span;
    }
}
