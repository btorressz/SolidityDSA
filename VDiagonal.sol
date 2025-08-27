//Attempt two: Successful 
//The first version had a “stack too deep” compiler error. In that version, my recursive _dfs function was taking 
//too many parameters (grid, m, n, di, dj, memo, etc.), and it overflowed the EVM stack. To fix it,
// I simplified the design: I moved the memoization into contract-level mappings with an epoch counter, used small
// helper functions for direction lookups instead of passing arrays, and trimmed _dfs down to just t
//he essential parameters. This way the code compiles cleanly without hitting the stack limit.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

/// @title Longest V-diagonal path with at most one clockwise turn
/// @notice Grid contains digits; path must follow next-digit rule and move diagonally
contract VDiagonal {
    // Memo epoching to avoid clearing storage between calls
    mapping(uint256 => uint256) private memoVal; // key -> value (length)
    mapping(uint256 => uint256) private memoTag; // key -> epoch
    uint256 private epoch; // increases every external call

    /// @dev next digit rule: 1->2, 2->0, 0->2, else invalid (-1)
    function _nextDigit(int256 d) internal pure returns (int256) {
        if (d == 1) return 2;
        if (d == 2) return 0;
        if (d == 0) return 2;
        return -1;
    }

    /// @dev direction components for dir in {0,1,2,3}
    /// 0:(+1,+1), 1:(-1,+1), 2:(+1,-1), 3:(-1,-1)
    function _di(uint8 dir) internal pure returns (int256) {
        if (dir == 0) return 1;
        if (dir == 1) return -1;
        if (dir == 2) return 1;
        // dir == 3
        return -1;
    }
    function _dj(uint8 dir) internal pure returns (int256) {
        if (dir == 0) return 1;
        if (dir == 1) return 1;
        if (dir == 2) return -1;
        // dir == 3
        return -1;
    }

    /// @dev clockwise dir: (di,dj) -> (dj,-di)
    /// mapping: 0->2, 1->0, 2->3, 3->1
    function _clockwise(uint8 dir) internal pure returns (uint8) {
        if (dir == 0) return 2;
        if (dir == 1) return 0;
        if (dir == 2) return 3;
        return 1; // dir == 3
    }

    /// @notice Returns longest valid path length
    /// @param grid matrix of ints; must be rectangular (all rows same length)
    function lenOfVDiagonal(int256[][] memory grid) external returns (int256 maxLen) {
        uint256 m = grid.length;
        require(m > 0, "empty grid");
        uint256 n = grid[0].length;
        require(n > 0, "empty row");
        for (uint256 i = 1; i < m; i++) {
            require(grid[i].length == n, "ragged grid");
        }

        // start a fresh memo epoch
        unchecked { epoch++; if (epoch == 0) epoch = 1; }

        for (uint256 i = 0; i < m; i++) {
            for (uint256 j = 0; j < n; j++) {
                if (grid[i][j] != 1) continue;
                for (uint8 d = 0; d < 4; d++) {
                    int256 cand = _dfs(i, j, d, 0, grid);
                    if (cand > maxLen) maxLen = cand;
                }
            }
        }
    }

    // depth-first search with memo
    function _dfs(
        uint256 i,
        uint256 j,
        uint8 dir,
        uint8 turned,              // 0 or 1
        int256[][] memory grid
    ) internal returns (int256) {
        uint256 n = grid[0].length;
        uint256 key = (((i * n) + j) * 8) + uint256(dir) * 2 + uint256(turned);

        if (memoTag[key] == epoch) {
            return int256(memoVal[key]);
        }

        int256 cur = grid[i][j];
        int256 next = _nextDigit(cur);
        int256 best = 1; // include current cell

        // straight move
        {
            int256 ni = int256(i) + _di(dir);
            int256 nj = int256(j) + _dj(dir);
            if (ni >= 0 && nj >= 0 && uint256(ni) < grid.length && uint256(nj) < n) {
                if (grid[uint256(ni)][uint256(nj)] == next) {
                    int256 cand = 1 + _dfs(uint256(ni), uint256(nj), dir, turned, grid);
                    if (cand > best) best = cand;
                }
            }
        }

        // one clockwise turn if not yet turned
        if (turned == 0) {
            uint8 ndir = _clockwise(dir);
            int256 ti = int256(i) + _dj(dir);     // dj becomes new di
            int256 tj = int256(j) - _di(dir);     // -di becomes new dj
            if (ti >= 0 && tj >= 0 && uint256(ti) < grid.length && uint256(tj) < n) {
                if (grid[uint256(ti)][uint256(tj)] == next) {
                    int256 cand = 1 + _dfs(uint256(ti), uint256(tj), ndir, 1, grid);
                    if (cand > best) best = cand;
                }
            }
        }

        memoTag[key] = epoch;
        memoVal[key] = uint256(best);
        return best;
    }
}




//Attempt one 
/*
pragma solidity ^0.8.30;

/// @title Longest V-diagonal path with at most one clockwise turn
/// @notice Grid contains digits; path must follow next-digit rule and move diagonally
contract VDiagonal {
    // next digit rule: 1->2, 2->0, 0->2, else invalid (-1)
    function _nextDigit(int256 d) internal pure returns (int256) {
        if (d == 1) return 2;
        if (d == 2) return 0;
        if (d == 0) return 2;
        return -1;
    }

    /// @param grid matrix of ints (use 0,1,2 per the rule)
    /// @return maxLen length of the longest valid path
    function lenOfVDiagonal(int256[][] memory grid) external pure returns (int256 maxLen) {
        uint256 m = grid.length;
        require(m > 0, "empty grid");
        uint256 n = grid[0].length;
        require(n > 0, "empty row");

        // directions: 0:(+1,+1), 1:(-1,+1), 2:(+1,-1), 3:(-1,-1)
        int256[4] memory di = [int256(1), int256(-1), int256(1), int256(-1)];
        int256[4] memory dj = [int256(1), int256(1), int256(-1), int256(-1)];

        // memo: m * n * 4 * 2, initialized to -1
        uint256 memoSize = m * n * 8;
        int256[] memory memo = new int256[](memoSize);
        for (uint256 t = 0; t < memoSize; t++) {
            memo[t] = -1;
        }

        // scan starts only from cells == 1 (matches Rust)
        for (uint256 i = 0; i < m; i++) {
            // optional row-length checks (ragged arrays unsupported): assume rectangular input
            require(grid[i].length == n, "ragged grid");
            for (uint256 j = 0; j < n; j++) {
                if (grid[i][j] != 1) continue;
                for (uint256 d = 0; d < 4; d++) {
                    int256 cur = _dfs(
                        int256(i),
                        int256(j),
                        uint8(d),
                        0, // turned = 0
                        grid,
                        m,
                        n,
                        di,
                        dj,
                        memo
                    );
                    if (cur > maxLen) maxLen = cur;
                }
            }
        }
    }

    // depth-first search with memo
    function _dfs(
        int256 i,
        int256 j,
        uint8 dir,
        uint8 turned, // 0 or 1
        int256[][] memory grid,
        uint256 m,
        uint256 n,
        int256[4] memory di,
        int256[4] memory dj,
        int256[] memory memo
    ) internal pure returns (int256) {
        uint256 key = _key(uint256(i), uint256(j), dir, turned, n);
        int256 cached = memo[key];
        if (cached != -1) return cached;

        int256 cur = grid[uint256(i)][uint256(j)];
        int256 next = _nextDigit(cur);
        int256 best = 1; // at least the current cell

        // straight move
        {
            int256 ni = i + di[dir];
            int256 nj = j + dj[dir];
            if (ni >= 0 && nj >= 0 && ni < int256(m) && nj < int256(n)) {
                if (grid[uint256(ni)][uint256(nj)] == next) {
                    int256 cand = 1 + _dfs(ni, nj, dir, turned, grid, m, n, di, dj, memo);
                    if (cand > best) best = cand;
                }
            }
        }

        // one clockwise turn if not yet turned
        if (turned == 0) {
            // clockwise: (di, dj) -> (dj, -di)
            int256 ndi = dj[dir];
            int256 ndj = -di[dir];

            int256 ti = i + ndi;
            int256 tj = j + ndj;
            if (ti >= 0 && tj >= 0 && ti < int256(m) && tj < int256(n)) {
                if (grid[uint256(ti)][uint256(tj)] == next) {
                    // map (ndi, ndj) back to dir index
                    uint8 ndir = _dirIndex(ndi, ndj, di, dj);
                    int256 cand = 1 + _dfs(ti, tj, ndir, 1, grid, m, n, di, dj, memo);
                    if (cand > best) best = cand;
                }
            }
        }

        memo[key] = best;
        return best;
    }

    // map a (di,dj) pair back to 0..3
    function _dirIndex(
        int256 ndi,
        int256 ndj,
        int256[4] memory di,
        int256[4] memory dj
    ) internal pure returns (uint8) {
        for (uint8 k = 0; k < 4; k++) {
            if (di[k] == ndi && dj[k] == ndj) return k;
        }
        // should not happen for valid inputs
        return 0;
    }

    // flatten (i, j, dir, turned) to index in memo
    function _key(
        uint256 i,
        uint256 j,
        uint8 dir,
        uint8 turned,
        uint256 n
    ) internal pure returns (uint256) {
        // layout: (((i * n) + j) * 8) + dir*2 + turned
        return (((i * n) + j) * 8) + uint256(dir) * 2 + uint256(turned);
    }
}
*/
