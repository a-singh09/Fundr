// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Fundr} from "../../src/Fundr.sol";
import {FundingVault} from "../../src/FundingVault.sol";
import {VotingPowerToken} from "../../src/VotingPowerToken.sol";
import {DeployFundr} from "../../script/DeployFundr.s.sol";
import {HelperConfig} from "../../script/HelperConfig.s.sol";

contract FundrTest is Test {
    HelperConfig helperConfig;
    Fundr fundr;

    function setUp() external {
        DeployFundr deployFundr = new DeployFundr();
        (fundr, helperConfig) = deployFundr.run();
    }

    function testFuzzDeployFundingVault(
        address _fundingToken,
        address _votingToken,
        uint256 _minRequestableAmount,
        uint256 _maxRequestableAmount,
        uint256 _tallyDate,
        address _owner
    ) public {
        vm.assume(_fundingToken != address(0));
        vm.assume(_votingToken != address(0));
        vm.assume(_owner != address(0));
        vm.assume(_tallyDate > block.timestamp);
        vm.assume(_maxRequestableAmount > 0);
        vm.assume(_minRequestableAmount <= _maxRequestableAmount);

        fundr.deployFundingVault(_fundingToken, _votingToken, _minRequestableAmount, _maxRequestableAmount, _tallyDate);

        uint256 totalVaults = fundr.getTotalNumberOfFundingVaults();
        address fundingVaultAddress = fundr.getFundingVault(totalVaults);
        assertEq(totalVaults, 1);
        assertTrue(fundingVaultAddress != address(0));
    }
}
