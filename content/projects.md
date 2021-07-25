+++
title = "Projects"
slug = "projects"
+++

[crypto-trailing-dca](https://github.com/ericfuerstenberg/crypto-trailing-dca)

* API-driven bot written in Python 3, leveraging ccxt library, deployed on AWS EC2
* Provides trailing stop functionality for orders on popular crypto exchange (Coinbase Pro)
* Implements configurable “buy-side” and “sell-side” DCA strategies that allow users to:
    * schedule automatic ACH deposits & purchases using trailing-stop buy orders
    * maximize profits by executing an exit strategy based on predefined take-profit thresholds and trailing-stop sell orders
