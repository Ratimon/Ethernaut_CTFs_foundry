// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Script} from "@forge-std/Script.sol";
import {Fallback} from "@main/1_Fallback.sol";


contract DeployFallbackScript is Script {
    Fallback fallbackChallenge;

    function run() public {
        vm.startBroadcast();
        fallbackChallenge = new Fallback();
        vm.stopBroadcast();
    }
}
