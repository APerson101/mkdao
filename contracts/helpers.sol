// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "./HederaTokenService.sol";
import "./HederaResponseCodes.sol";

contract HTS is HederaTokenService {
    function tokenAssociate(address sender, address tokenAddress) external {
        int256 response = HederaTokenService.associateToken(
            sender,
            tokenAddress
        );

        if (response != HederaResponseCodes.SUCCESS) {
            revert("Associate Failed");
        }
    }

    function tokenTransfer(
        address tokenId,
        address fromAccountId,
        address toAccountId,
        int64 tokenAmount
    ) external returns (int256) {
        int256 response = HederaTokenService.transferToken(
            tokenId,
            toAccountId,
            fromAccountId,
            tokenAmount
        );

        if (response != HederaResponseCodes.SUCCESS) {
            revert("Transfer Failed");
        } else return response;
    }

    function tokenDissociate(address sender, address tokenAddress) external {
        int256 response = HederaTokenService.dissociateToken(
            sender,
            tokenAddress
        );

        if (response != HederaResponseCodes.SUCCESS) {
            revert("Dissociate Failed");
        }
    }
}
