# Fundr

[Git Source](https://github.com/StabilityNexus/Fundr/blob/64b2ecb7c60a5a1802be455db0565e9d73fc2a00/app/blockchain/src/Fundr.sol)

**Inherits:**
Ownable

**Author:**
Aditya Bhattad

This is the main Fundr contract that will be used for deployment and keeping track of all the funding vaults.

## State Variables

### s_fundingVaultIdCounter

```solidity
uint256 private s_fundingVaultIdCounter;
```

### s_fundingVaults

```solidity
mapping(uint256 fundingVaultId => address fundingVault) private s_fundingVaults;
```

### s_platformFee

```solidity
uint256 private s_platformFee;
```

## Functions

### constructor

```solidity
constructor(uint256 _platformFee) Ownable(msg.sender);
```

**Parameters**

| Name           | Type      | Description                                                               |
| -------------- | --------- | ------------------------------------------------------------------------- |
| `_platformFee` | `uint256` | The fee that will be charged by the platform for using the Fundr platform |

### deployFundingVault

```solidity
function deployFundingVault(
    address _fundingToken,
    address _votingToken,
    uint256 _minRequestableAmount,
    uint256 _maxRequestableAmount,
    uint256 _tallyDate
) external returns (address);
```

**Parameters**

| Name                    | Type      | Description                                                                          |
| ----------------------- | --------- | ------------------------------------------------------------------------------------ |
| `_fundingToken`         | `address` | The token that will be used to fund the proposals                                    |
| `_votingToken`          | `address` | The token that will be used to vote on the proposals                                 |
| `_minRequestableAmount` | `uint256` | The minimum amount that can be requested by a single proposal from the funding vault |
| `_maxRequestableAmount` | `uint256` | The maximum amount that can be requested by a single proposal from the funding vault |
| `_tallyDate`            | `uint256` | The date when the voting will end and the proposals will be tallied                  |

### modityPlatformFee

```solidity
function modityPlatformFee(uint256 _platformFee) external onlyOwner;
```

**Parameters**

| Name           | Type      | Description                                                                                  |
| -------------- | --------- | -------------------------------------------------------------------------------------------- |
| `_platformFee` | `uint256` | The new platform fee percentage to be set (i.e. 1 for 1% of amount every proposal will get.) |

### withdrawPlatformFee

```solidity
function withdrawPlatformFee(address recepient, address token) external onlyOwner;
```

**Parameters**

| Name        | Type      | Description                               |
| ----------- | --------- | ----------------------------------------- |
| `recepient` | `address` | The address to receive the withdrawn fees |
| `token`     | `address` | The address of the token to withdraw      |

### getFundingVault

```solidity
function getFundingVault(uint256 _fundingVaultId) external view returns (address);
```

### getTotalNumberOfFundingVaults

```solidity
function getTotalNumberOfFundingVaults() external view returns (uint256);
```

### getPlatformFee

```solidity
function getPlatformFee() external view returns (uint256);
```

## Events

### FundingVaultDeployed

```solidity
event FundingVaultDeployed(address indexed fundingVault);
```

### TransferTokens

```solidity
event TransferTokens(address indexed token, address indexed recepient, uint256 amount);
```

## Errors

### Fundr\_\_CannotBeAZeroAddress

```solidity
error Fundr__CannotBeAZeroAddress();
```

### Fundr\_\_TallyDateCannotBeInThePast

```solidity
error Fundr__TallyDateCannotBeInThePast();
```

### Fundr\_\_MinRequestableAmountCannotBeGreaterThanMaxRequestableAmount

```solidity
error Fundr__MinRequestableAmountCannotBeGreaterThanMaxRequestableAmount();
```

### Fundr\_\_MaxRequestableAmountCannotBeZero

```solidity
error Fundr__MaxRequestableAmountCannotBeZero();
```

### Fundr\_\_TransferFailed

```solidity
error Fundr__TransferFailed(address token, address recepient, uint256 amount);
```
