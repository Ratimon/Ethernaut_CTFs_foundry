// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Script} from "@forge-std/Script.sol";
import {Privacy} from "@main/12_Privacy.sol";

contract DeployPrivacyScript is Script {
    Privacy privacyChallenge;

    function run() public {
        // uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        // string memory mnemonic = vm.envString("MNEMONIC");

        // address is already funded with ETH
        string memory mnemonic ="test test test test test test test test test test test junk";
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 1); //  address = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8
        address deployer = vm.addr(deployerPrivateKey);

        vm.startBroadcast(deployerPrivateKey);

        bytes32[3] memory data;
        data[0] = keccak256(abi.encodePacked(deployer, "0"));
        data[1] = keccak256(abi.encodePacked(deployer, "1"));
        data[2] = keccak256(abi.encodePacked(deployer, "2"));

        privacyChallenge = new Privacy(data);

        vm.stopBroadcast();
    }
}