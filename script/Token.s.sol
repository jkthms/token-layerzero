// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Script.sol";
import "../src/Token.sol";

contract DeployToken is Script {
    // Hyperliquid Testnet: 998
    address constant HYPERLIQUID_TESTNET_LZ_ENDPOINT = 0x6Ac7bdc07A0583A362F1497252872AE6c0A5F5B8;

    // Base Mainnet: 8453
    address constant BASE_MAINNET_LZ_ENDPOINT = 0x1a44076050125825900e736c501f859c50fE728c;

    // Base Sepolia: 84532
    address constant BASE_SEPOLIA_LZ_ENDPOINT = 0x6EDCE65403992e310A62460808c4b910D972f10f;

    // Ethereum Mainnet: 1
    address constant ETHEREUM_MAINNET_LZ_ENDPOINT = 0x1a44076050125825900e736c501f859c50fE728c;

    // Ethereum Sepolia: 11155111
    address constant SEPOLIA_LZ_ENDPOINT = 0x6EDCE65403992e310A62460808c4b910D972f10f;

    function run() external {
        // Determine which network we are on by chainid
        uint256 chain = block.chainid;

        string memory chain_pretty;
        address endpoint;
        address treasury;
        if (chain == 1) {
            chain_pretty = "Ethereum Mainnet";
            endpoint = ETHEREUM_MAINNET_LZ_ENDPOINT;
            treasury = address(0x0000000000000000000000000000000000000000);
        } else if (chain == 11155111) {
            chain_pretty = "Ethereum Sepolia";
            endpoint = SEPOLIA_LZ_ENDPOINT;
            treasury = address(0x0000000000000000000000000000000000000000);
        } else if (chain == 8453) {
            chain_pretty = "Base Mainnet";
            endpoint = BASE_MAINNET_LZ_ENDPOINT;
            treasury = address(0x0000000000000000000000000000000000000000);
        } else if (chain == 84532) {
            chain_pretty = "Base Sepolia";
            endpoint = BASE_SEPOLIA_LZ_ENDPOINT;
            treasury = address(0x0000000000000000000000000000000000000000);
        } else if (chain == 998) {
            chain_pretty = "Hyperliquid Testnet";
            endpoint = HYPERLIQUID_TESTNET_LZ_ENDPOINT;
            treasury = address(0x0000000000000000000000000000000000000000);
        } else {
            revert("REVERT: block.chainid was not handled...");
        }

        vm.startBroadcast();
        string memory name = "MockToken";
        string memory symbol = "MTOK";

        // Deploy the MockERC20 contract with the LayerZero endpoint for this chain
        Token token = new Token(name, symbol, endpoint, treasury);
        console.log("SUCCESS: Token deployed on %s to address: %s", chain_pretty, address(token));
        vm.stopBroadcast();
    }
}
