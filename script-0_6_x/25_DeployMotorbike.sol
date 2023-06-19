// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import {Script} from "@forge-std/Script.sol";
import {Engine, Motorbike} from "@main-0_6_x/25_Motorbike.sol";

contract DeployMotorbikeScript is Script {
    Engine engine;
    // Motorbike motorbikeProxy;
    Engine motorbikeChallenge;

    function run() public {
        // uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        // string memory mnemonic = vm.envString("MNEMONIC");

        // address is already funded with ETH
        string memory mnemonic ="test test test test test test test test test test test junk";
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 1); //  address = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8

        vm.startBroadcast(deployerPrivateKey);

        engine = new Engine();
        Motorbike proxy = new Motorbike(address(engine));
        motorbikeChallenge = Engine(payable(address(proxy)));

        vm.stopBroadcast();
    }
}
