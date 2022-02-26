# Smartcontract Tools

A repo of smartcontract tools either for use or L&D.

**Contents:**

- [check-rinkeby-subs](https://github.com/dangitsdavid/smartcontract-tools#check-rinkeby-subs-python)
- [check-rpc-blockheight](https://github.com/dangitsdavid/smartcontract-tools#check-rpc-blockheight-bash)

## check-rinkeby-subs (Python)

Checks if Chainlink Ethereum Rinkeby VRF subscriptions are underfunded

| Flag            | Description                           |
| --------------- | ------------------------------------- |
| --rpc           | Ethereum Rinkeby RPC endpoint         |
| -gl, --gaslimit | Requestor's transaction max gas limit |
| -g, --gwei      | Gwei set in VRF request               |
| -s, --subid     | Subscription ID                       |

**Running the script:**

```
❯ python3 checkSubscription.py -gl 1000000 -g 30 -s 120

Subscription 120 is underfunded?
 False
```

## check-rpc-blockheight (Bash)

Interactive script to RPC endpoint's block height in either single or dual (comparison) mode.

| Flag | Description            |
| ---- | ---------------------- |
| -r   | RPC Mode (https, http) |
| -w   | WSS Mode (wss, ws)     |

**Running the script:**

```
./checkRPC.sh -r

RPC endpoint selected

How many RPCs? (min: 1, max: 2)
2

RPC1 websocket endpoint:
https://rpc.ftm.tools
RPC2 websocket endpoint:
https://rpc.ftm.tools

Processing...

OUTPUT:
RPC1's blockheight is: 32006652
RPC2's blockheight is: 32006652

Block height difference is: 0

NOTE: Difference of 1 - 5 blocks height is normal.
```
