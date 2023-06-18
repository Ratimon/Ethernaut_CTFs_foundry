// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Script} from "@forge-std/Script.sol";
import {Preservation, LibraryContract} from "@main/16_Preservation.sol";

contract DeployPreservationScript is Script {
    address timeZone1LibraryAddress;
    address timeZone2LibraryAddress;

    Preservation preservationChallenge;

    function run() public {
        // uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        // string memory mnemonic = vm.envString("MNEMONIC");

        // address is already funded with ETH
        string memory mnemonic = "test test test test test test test test test test test junk";
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 1); //  address = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8

        vm.startBroadcast(deployerPrivateKey);

        timeZone1LibraryAddress = address(new LibraryContract());
        timeZone2LibraryAddress = address(new LibraryContract());

        preservationChallenge = new Preservation(timeZone1LibraryAddress, timeZone2LibraryAddress);

        vm.stopBroadcast();
    }
}
