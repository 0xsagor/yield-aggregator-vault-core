# Yield Aggregator Vault Core

This repository provides a high-quality, professional implementation of a DeFi Yield Aggregator. It allows users to deposit stablecoins into a central vault, which then routes those assets to the highest-yielding opportunities.

### Features
* **Auto-Compounding:** Reinvests rewards back into the pool to maximize user returns via compound interest.
* **Share-Based System:** Uses a "Vault Share" (ERC-20) approach to track user deposits and proportional earnings.
* **Security:** Integrated with OpenZeppelin's `ReentrancyGuard` and `SafeERC20` to prevent common DeFi vulnerabilities.
* **Provider Agnostic:** Designed to be easily extended to support Aave, Compound, or Uniswap V3 liquidity positions.

### Workflow
1. **Deposit:** User deposits USDC/DAI. The vault mints "Vault Shares" based on the current exchange rate.
2. **Harvest:** The strategist calls `harvest()` to collect rewards and move capital to the highest APR provider.
3. **Withdraw:** User burns shares to reclaim their original principal plus the accumulated yield.

### License
MIT
