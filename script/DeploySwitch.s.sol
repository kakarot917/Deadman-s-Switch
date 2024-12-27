//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/script.sol";
import {Switch} from "../src/Switch.sol";

contract deployer is Script {
    function run() external returns (Switch) {
        vm.startBroadcast();
        Switch hello = new Switch();
        vm.stopBroadcast();

        return hello;
    }
}
