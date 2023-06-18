// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Script} from "@forge-std/Script.sol";
import {Recovery} from "@main/17_Recovery.sol";

contract DeployRecoveryScript is Script {
    Recovery recoveryChallenge;

    function run() public {
        // uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        // string memory mnemonic = vm.envString("MNEMONIC");

        // address is already funded with ETH
        string memory mnemonic = "test test test test test test test test test test test junk";
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 1); //  address = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8

        vm.startBroadcast(deployerPrivateKey);

        recoveryChallenge = new Recovery();
        recoveryChallenge.generateToken("InitialToken", uint256(100000));

        address payable tokenAddress = payable(
            address(
                uint160(
                    uint256(
                        keccak256(
                            abi.encodePacked(bytes1(0xd6), bytes1(0x94), address(recoveryChallenge), bytes1(0x01))
                        )
                    )
                )
            )
        );

        (bool success,) = address(tokenAddress).call{value: 0.001 ether}("");
        require(success);

        vm.stopBroadcast();
    }
}
