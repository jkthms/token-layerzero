// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Script.sol";
import "../src/Token.sol";

contract DeployToken is Script {
    // Constants for LayerZero endpoints on each chain (for convenience)
    address constant SEPOLIA_LZ_ENDPOINT = 0xae92d5aD7583AD66E49A0c67BAd18F6ba52dDDc1;
    address constant HYPERLIQUID_TESTNET_LZ_ENDPOINT = 0x83C7CF6f3aA55b4ac106F7FB1c76dA5D1b3b3aBD;

    function run() external {
        // Determine which network we are on by chainid
        uint256 chain = block.chainid;

        string memory chain_pretty;
        address endpoint;
        if (chain == 11155111) {
            chain_pretty = "Sepolia";
            endpoint = SEPOLIA_LZ_ENDPOINT;
        } else if (chain == 998) {
            chain_pretty = "Hyperliquid Testnet";
            endpoint = HYPERLIQUID_TESTNET_LZ_ENDPOINT;
        } else {
            revert("REVERT: block.chainid was not handled...");
        }

        vm.startBroadcast();
        string memory name = "MockToken";
        string memory symbol = "MTOK";
        address delegate = address(0x0000000000000000000000000000000000000000);

        // Deploy the MockERC20 contract with the LayerZero endpoint for this chain
        Token token = new Token(name, symbol, endpoint, delegate);
        console.log("SUCCESS: Token deployed on %s to address: %s", chain_pretty, address(token));
        vm.stopBroadcast();
    }
}
