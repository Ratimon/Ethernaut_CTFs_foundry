// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Script} from "@forge-std/Script.sol";
import {Fallback} from "@main/1_Fallback.sol";


contract SolveFallbackScript is Script {

    // Fallback fallback;

    function run() public {
        vm.startBroadcast();
        vm.stopBroadcast();
    }
}
