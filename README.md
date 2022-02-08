# Smartcontract Tools

A repo of smartcontract tools either for use or L&D.

## check-rinkeby-subs (Python)

Checks if Chainlink Ethereum Rinkeby VRF subscriptions are underfunded

| Flag            | Description                           |
| --------------- | ------------------------------------- |
| --rpc           | Ethereum Rinkeby RPC endpoint         |
| -gl, --gaslimit | Requestor's transaction max gas limit |
| -g, --gwei      | Gwei set in VRF request               |
| -s, --subid     | Subscription ID                       |

### Running the script:

```
❯ python3 checkSubscription.py -gl 1000000 -g 30 -s 120

Subscription 120 is underfunded?
 False
```
