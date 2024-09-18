// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {MockFundr} from "../../src/mocks/MockFundr.sol";
import {HelperConfig} from "../HelperConfig.s.sol";

contract DeployMockFundr is Script {
    function run() external returns (MockFundr mockFundr, HelperConfig helperConfig) {
        helperConfig = new HelperConfig();
        uint256 deployerKey = helperConfig.activeNetworkConfig();

        vm.startBroadcast(deployerKey);
        uint256 platformFee = 1;
        mockFundr = new MockFundr(platformFee);
        vm.stopBroadcast();
        string memory deploymentInfo = string.concat('{"mockFundr":"', vm.toString(address(mockFundr)), '"}');
        vm.writeFile("../web-app/src/blockchain/deployments/anvil/fundr_deployment.json", deploymentInfo);
    }
}
