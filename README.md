# Blockchain-Based Distributed Energy Trading System

A decentralized energy trading platform built with Clarity smart contracts that enables peer-to-peer energy trading between producers and consumers.

## Overview

This system allows energy producers (such as solar panel owners or wind farm operators) to sell excess energy directly to consumers without intermediaries. The blockchain ensures transparency, security, and immutability of all transactions.

## Smart Contracts

The system consists of five main smart contracts:

1. **Producer Verification Contract**: Validates and registers energy generators
2. **Consumer Verification Contract**: Validates and registers energy users
3. **Production Tracking Contract**: Records energy generation amounts
4. **Consumption Tracking Contract**: Records energy usage
5. **Trading Contract**: Manages peer-to-peer energy exchange

## Features

- **Verification System**: Only verified producers and consumers can participate
- **Production Tracking**: Records and certifies energy production
- **Consumption Tracking**: Records and verifies energy consumption
- **Trading Platform**: Enables creating and accepting trade offers
- **Admin Controls**: Verification and certification by trusted authorities

## Contract Functions

### Producer Verification
- `register-producer`: Register as a new energy producer
- `verify-producer`: Admin function to verify a producer
- `is-verified-producer`: Check if a producer is verified
- `get-producer-details`: Get details about a producer

### Consumer Verification
- `register-consumer`: Register as a new energy consumer
- `verify-consumer`: Admin function to verify a consumer
- `is-verified-consumer`: Check if a consumer is verified
- `get-consumer-details`: Get details about a consumer

### Production Tracking
- `record-production`: Record energy production for a period
- `certify-production`: Admin function to certify production
- `get-production`: Get production details
- `get-total-production`: Get total system production

### Consumption Tracking
- `record-consumption`: Record energy consumption for a period
- `verify-consumption`: Admin function to verify consumption
- `get-consumption`: Get consumption details
- `get-total-consumption`: Get total system consumption

### Trading
- `create-trade-offer`: Create an offer to sell energy
- `accept-trade`: Accept an existing trade offer
- `cancel-trade`: Cancel your own trade offer
- `get-trade-offer`: Get details about a trade offer
- `get-completed-trade`: Get details about a completed trade

## Getting Started

### Prerequisites
- Clarity development environment

### Installation
1. Clone this repository
2. Deploy the contracts to your Stacks blockchain node

### Usage Example

```clarity
;; Register as a producer
(contract-call? .producer-verification register-producer "Solar Farm Alpha" u1000 "California")

;; Record energy production
(contract-call? .production-tracking record-production u1 u500)

;; Create a trade offer
(contract-call? .trading create-trade-offer u300 u10 u1)

;; Accept a trade offer (as a consumer)
(contract-call? .trading accept-trade u1)
