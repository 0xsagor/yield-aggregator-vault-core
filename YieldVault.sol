// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "./VaultShare.sol";

contract YieldVault is ReentrancyGuard {
    using SafeERC20 for IERC20;

    IERC20 public immutable asset;
    VaultShare public immutable shares;

    constructor(address _asset) {
        asset = IERC20(_asset);
        shares = new VaultShare();
    }

    function deposit(uint256 amount) external nonReentrant {
        uint256 totalAsset = asset.balanceOf(address(this));
        uint256 totalShares = shares.totalSupply();

        uint256 sharesToMint;
        if (totalShares == 0) {
            sharesToMint = amount;
        } else {
            sharesToMint = (amount * totalShares) / totalAsset;
        }

        asset.safeTransferFrom(msg.sender, address(this), amount);
        shares.mint(msg.sender, sharesToMint);
    }

    function withdraw(uint256 shareAmount) external nonReentrant {
        uint256 totalAsset = asset.balanceOf(address(this));
        uint256 totalShares = shares.totalSupply();

        uint256 amountToWithdraw = (shareAmount * totalAsset) / totalShares;

        shares.burn(msg.sender, shareAmount);
        asset.safeTransfer(msg.sender, amountToWithdraw);
    }

    function getPricePerShare() public view returns (uint256) {
        if (shares.totalSupply() == 0) return 1e18;
        return (asset.balanceOf(address(this)) * 1e18) / shares.totalSupply();
    }
}
