// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {OFT} from "@layerzerolabs/oft-evm/contracts/OFT.sol";

/**
 * @title Token
 * @author jkthms (https://github.com/jkthms)
 * @dev A mock ERC20 token implementation that combines OpenZeppelin's ERC20 with LayerZero's OFT functionality
 * @notice This contract is used for testing cross-chain token transfers using the LayerZero protocol
 */
contract Token is OFT {
    constructor(string memory _name, string memory _symbol, address _lzEndpoint, address _delegate)
        OFT(_name, _symbol, _lzEndpoint, _delegate)
        Ownable(_delegate)
    {
        // Mint initial supply to the deployer if the chain is Ethereum mainnet
        if (block.chainid == 1) {
            _mint(_msgSender(), 1e24);
        }
    }
}
