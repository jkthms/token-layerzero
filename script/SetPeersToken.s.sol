// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Script.sol";
import "../src/Token.sol";

contract SetPeersToken is Script {
    // Store a mapping of LayerZero UID to deployment addresses on each chain
    mapping(uint256 => address) public peers;

    function run() external {
        // Hyperliquid Testnet: 998
        peers[998] = 0x6Ac7bdc07A0583A362F1497252872AE6c0A5F5B8;

        // Base Mainnet: 30184 (EID)
        peers[30184] = 0x1a44076050125825900e736c501f859c50fE728c;

        // Base Sepolia: 40245 (EID)
        peers[40245] = 0x6EDCE65403992e310A62460808c4b910D972f10f;

        // Ethereum Mainnet: 1
        peers[1] = 0x1a44076050125825900e736c501f859c50fE728c;

        // Ethereum Sepolia: 11155111
        peers[11155111] = 0x6EDCE65403992e310A62460808c4b910D972f10f;

        // Determine which network we are on by chainid
        uint256 chain = block.chainid;

        vm.startBroadcast();
        // TODO: Set the peers for the token on the given chain by looping through the mapping
        vm.stopBroadcast();
    }
}
