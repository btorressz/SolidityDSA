// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

/// @title Soup Servings (LeetCode 808)
/// @notice Calculates the probability that soup A empties first, using fixed-point math (1e18 = 1.0).
contract SoupServings {
    uint256 private constant ONE = 1e18;   // represents 1.0
    uint256 private constant HALF = 5e17;  // represents 0.5

    // Stores memoized results for states (a,b) using a packed key
    mapping(uint32 => uint256) private memo;

    /// @param n Initial amount of soup in milliliters (same for A and B)
    /// @return prob1e18 Probability scaled by 1e18 (e.g., 1e18 = 100%)
    function soupServings(uint256 n) external returns (uint256 prob1e18) {
        // If both are empty right away, prob = 0.5
        if (n == 0) return HALF;
        // For large n, answer is ~1.0, so shortcut
        if (n >= 4800) return ONE;

        // Scale down by 25 since servings are in multiples of 25 ml
        uint16 m = uint16((n + 24) / 25);

        return _dp(m, m);
    }

    // Recursive DP with memoization
    function _dp(uint16 a, uint16 b) internal returns (uint256) {
        if (a == 0 && b == 0) return HALF;
        if (a == 0) return ONE;
        if (b == 0) return 0;

        // Check cache
        uint32 key = _packKey(a, b);
        uint256 cached = memo[key];
        if (cached != 0) return cached;

        // Four possible serving operations
        uint16 a1 = _saturatingSub(a, 4);
        uint16 b1 = b;

        uint16 a2 = _saturatingSub(a, 3);
        uint16 b2 = _saturatingSub(b, 1);

        uint16 a3 = _saturatingSub(a, 2);
        uint16 b3 = _saturatingSub(b, 2);

        uint16 a4 = _saturatingSub(a, 1);
        uint16 b4 = _saturatingSub(b, 3);

        // Average over the 4 choices
        uint256 sum =
            _dp(a1, b1) +
            _dp(a2, b2) +
            _dp(a3, b3) +
            _dp(a4, b4);

        uint256 val = sum / 4;
        memo[key] = val;
        return val;
    }

    // Packs (a,b) into a 32-bit key
    function _packKey(uint16 a, uint16 b) private pure returns (uint32) {
        return (uint32(a) << 16) | uint32(b);
    }

    // Subtracts but floors at zero
    function _saturatingSub(uint16 x, uint16 y) private pure returns (uint16) {
        return x > y ? x - y : 0;
    }
}
