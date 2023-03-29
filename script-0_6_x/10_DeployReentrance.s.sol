// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import {Script} from "@forge-std/Script.sol";
import {Reentrance} from "@main-0_6_x/10_Reentrance.sol";

contract DeployReentranceScript is Script {
    Reentrance reentranceChallenge;

    function run() public {
        // uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        // string memory mnemonic = vm.envString("MNEMONIC");

        // address is already funded with ETH
        string memory mnemonic ="test test test test test test test test test test test junk";
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 1); //  address = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8
        // address deployer = vm.addr(deployerPrivateKey);

        vm.startBroadcast(deployerPrivateKey);

        reentranceChallenge = new Reentrance();
        // reentranceChallenge.donate{value: 10 ether}(deployer);

        vm.stopBroadcast();
    }
}
