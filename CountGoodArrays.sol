// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/// @title 3405. Count the Number of Arrays with K Matching Adjacent Elements 
contract CountGoodArrays {
    uint256 private constant MOD = 1_000_000_007;

    /// @notice Returns count of arrays of length n over [1..m] with exactly k pairs of equal adjacents
    function countGoodArrays(uint256 n, uint256 m, uint256 k) external pure returns (uint256) {
        // Basic feasibility checks
        if (n == 0) return 0;                // no arrays of length 0 in original constraints
        if (k > n - 1) return 0;             // cannot have more equal-adjacent pairs than n-1
        if (m == 0) return 0;                // no symbols to use
        // (m-1) will be used; require m >= 1 (already ensured by m==0 check)

        // Precompute factorials and inverse factorials up to n
        uint256[] memory fact = new uint256[](n + 1);
        uint256[] memory invFact = new uint256[](n + 1);

        fact[0] = 1;
        for (uint256 i = 1; i <= n; i++) {
            fact[i] = (fact[i - 1] * i) % MOD;
        }

        invFact[n] = modInv(fact[n]); // Fermat since MOD is prime
        for (uint256 i = n; i >= 1; i--) {
            invFact[i - 1] = (invFact[i] * i) % MOD;
            if (i == 1) break; // prevent underflow of i in the for-loop
        }

        // run_ways = C(n-1, k)
        uint256 runWays = (((fact[n - 1] * invFact[n - k - 1]) % MOD) * invFact[k]) % MOD;

        // assign_ways = m * (m-1)^(n-k-1)
        uint256 expPow = (n - k - 1); // safe since k <= n-1
        uint256 assignWays = (m % MOD) * modPow((m + MOD - 1) % MOD, expPow) % MOD;

        return (runWays * assignWays) % MOD;
    }

    /// @dev Fast modular exponentiation
    function modPow(uint256 a, uint256 e) internal pure returns (uint256) {
        uint256 res = 1;
        a %= MOD;
        while (e > 0) {
            if (e & 1 == 1) {
                res = (res * a) % MOD;
            }
            a = (a * a) % MOD;
            e >>= 1;
        }
        return res;
    }

    /// @dev Modular inverse via Fermat's little theorem: a^(MOD-2) mod MOD
    function modInv(uint256 a) internal pure returns (uint256) {
        // assuming 0 < a < MOD and MOD prime
        return modPow(a, MOD - 2);
    }
}
