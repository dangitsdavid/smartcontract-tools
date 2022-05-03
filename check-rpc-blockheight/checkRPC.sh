#!/bin/bash

rpcCount () {
  echo -e "How many RPCs? (min: 1, max: 2)"
  read "RPCCount"
}

singleInput () {
  echo -ne "\nRPC websocket endpoint:\n"
  read "RPC1"
  echo -e "\nProcessing..."
}

doubleInput () {
  echo -ne "\nRPC1 websocket endpoint:\n"
  read "RPC1"
  echo -ne "RPC2 websocket endpoint:\n"
  read "RPC2"
  echo -e "\nProcessing..."
}

errorInput () {
  echo -e '\nERROR: Invalid input\nMin: 1, Max: 2'
}

singleResult () {
  echo -e "\nOUTPUT:\nRPC's blockheight is: $((blockHeight))"
}

doubleResult () {
  echo -e "\nOUTPUT:\nRPC1's blockheight is: $((blockHeightOne)) \nRPC2's blockheight is: $((blockHeightTwo))"
  heightDifference="$((blockHeightTwo - blockHeightOne))"
  if [ $heightDifference -lt 0 ]; then
    heightDiff=$((-heightDifference))
    echo -e "\nBlock height difference is: $heightDiff\n"
  else
    heightDiff=$heightDifference
    echo -e "\nBlock height difference is: $heightDiff\n"
  fi
  echo -e "NOTE: Difference of 1 - 5 blocks height is normal.\n"
}

checkWSS () {
  rpcCount

  case $RPCCount in
    1)
      singleInput
      blockHeight=$(wscat -c "$RPC1" -x '{"jsonrpc": "2.0","method": "eth_blockNumber","params": [],"id": "1"}' | jq -r ."result")
      singleResult
      exit 0
      ;;
    2)
      doubleInput
      blockHeightOne=$(wscat -c "$RPC1" -x '{"jsonrpc": "2.0","method": "eth_blockNumber","params": [],"id": "1"}' | jq -r ."result")
      blockHeightTwo=$(wscat -c "$RPC2" -x '{"jsonrpc": "2.0","method": "eth_blockNumber","params": [],"id": "1"}' | jq -r ."result")
      doubleResult
      exit 0
      ;;
    *)
      errorInput
      exit 1
  esac
}

checkRPC () {
  rpcCount

  case $RPCCount in
    1)
      singleInput
      blockHeight=$(curl -s "$RPC1" -X POST -d '{"jsonrpc": "2.0","method": "eth_blockNumber","params": [],"id": "1"}' -H "Content-Type: application/json" | jq -r ."result")
      singleResult
      exit 0
      ;;
    2)
      doubleInput
      blockHeightOne=$(curl -s "$RPC1" -X POST -d '{"jsonrpc": "2.0","method": "eth_blockNumber","params": [],"id": "1"}' -H "Content-Type: application/json" | jq -r ."result")
      blockHeightTwo=$(curl -s "$RPC2" -X POST -d '{"jsonrpc": "2.0","method": "eth_blockNumber","params": [],"id": "1"}' -H "Content-Type: application/json" | jq -r ."result")
      doubleResult
      exit 0
      ;;
    *)
      errorInput
      exit 1
  esac
}

case $1 in
  -r|-R)
    echo -e "\nRPC endpoint selected\n"
    checkRPC
    exit 0
    ;;
  -w|-W)
    echo -e "\nWSS endpoint selected\n"
    checkWSS
    exit 0
    ;;
  *)
    echo -e "\nMissing required flags. Use either:\n -r RPC endpoint\n -w WSS endpoint\n"
    exit 1
    ;;
esac
