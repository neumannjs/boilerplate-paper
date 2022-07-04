Conclusion
==========

This paper presented an improvement to the algorithm of the original BDA. We showed that by approaching a payment channel from both sides instead of from one side, payment channels with a higher capacity than in the original BDA are now also susceptible to this attack. Since monitoring balances over time makes it possible to detect payments, it can be used to learn information about payments an adversary isn't part of [@Malavolta2017].
We exposed differences in the implementation of the BOLT specification by the main three clients. These differences led us to develop new attack that closes down payment channels where the attacker isn't part of. We estimated the proportions of each client in LN, by using self-reported information. Based on these proportions we estimated that this attack can be used to take down an important part of LN's entire network capacity.
