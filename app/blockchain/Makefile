RPC_URL := 127.0.0.1:8545
VERBOSITY := -vvvv
BROADCAST := --broadcast
LEGACY := --legacy

FORGE_SCRIPT := forge script
-include .env

deploy-mock-fundr:
	$(FORGE_SCRIPT) script/mocks/DeployMockFundr.s.sol:DeployMockFundr --rpc-url $(RPC_URL) $(VERBOSITY) $(BROADCAST) $(LEGACY)

deploy-mock-erc20:
	$(FORGE_SCRIPT) script/mocks/DeployMockERC20.s.sol:DeployMockERC20 --rpc-url $(RPC_URL) $(VERBOSITY) $(BROADCAST) $(LEGACY)


dmf: deploy-mock-fundr
dme: deploy-mock-erc20

deploy-sepolia:
	$(FORGE_SCRIPT) script/DeployFundr.s.sol:DeployFundr --rpc-url ${SEPOLIA_RPC_URL} --private-key ${PRIVATE_KEY} ${BROADCAST} --verify $(LEGACY) -vvvv

mock-all: deploy-mock-fundr deploy-mock-erc20



help:
	@echo "Available targets:"
	@echo "  deploy-mock-fundr (dmf)  : Deploy Fundr contract"
	@echo "  deploy-mock-erc20 (dme)      : Deploy MockERC20 contract"
	@echo "  mock-all                     : Deploy both contracts to anvil testnet"
	@echo "  help                         : Show this help message"

.PHONY: deploy-mock-fundr deploy-mock-erc20 deploy-fundr dmf dme df all help