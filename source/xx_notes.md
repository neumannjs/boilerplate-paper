<div>
<!-- 

Research Question: What improvements can be made to the BDA proposed by Joancomarti
Problem Statement: Currently a BDA limited by an upper bound set by the Max_Payment_Limit and is detectable.
Objective: To develop new or improved algorithms for BDA.
Achievements & Methods: Differences in software implementation between clients make it possible to circumvent the Max_Payment_Limit. Improvements on the BDA algorithm make detection harder.
Results: Modified BDA algorithm is able to detect at least 8% more channels, and is harder to detect while maintaining the same accuracy in testnet

Link to differential privacy in discussion? Claiming that the vulnerability discloses client software, which is another identifier to cross reference.

80.59% of high-capacity nodes are LND nodes
If the high-capacity node takes the role of Alice in the BDA algorithm
We can detect the balance for all channels Alice has with other LND and Eclair clients. (not c-lighting, because they close down the channel, which is a vulnerability)
95.06% of channels are with at least one LND node, but because of the c-lightning reaction of closing down channels not all of them are disclosable.
71.44% of the channels are with LND on one end and either LND or Eclair on the other end
So, 71.44% of the high-capacity channels are disclosable.
88.49% of channels are below max_payment limit, 11.51% are above
Of those 11.51 * 0.7144 = 8.22% are now also detectable.
88.49% + 7.73% = 96.22% of channels balances are disclosable
96.22%/89.10%= 8% improvement of original BDA attack



Proof that Payment Requests Denial is infeasible

Improvements in channel balance discovery algorithm, making it harder to identify a balance disclosure attack

The objective of the adversary Mallory M, is to disclose the balance that each node has in Channel AB. This means disclosing balanceAB and balanceBA. In our scenario

- M doesn't have an open channel with either A or B.
- The consecutive payment requests don't come in through the same node
- The amount pattern is randomized to a certain extent, without suffering from precision
- Channels with known balances, not belonging to the adversary, are included in routes

Quantify the trade-off between privacy and usability in the case of a randomized dropping rate.
Dropping rate might be infeasible in any case, because if if a payment channel consists of multiple hops, the overall drop rate will spiral out of control.

# Dynamic Absorption of Negative Balances

Provide proof that adding noise to payment requests gives anonymity guarantees that can be proven in a formal way

Additional masking solution the masking solution can be randomized, in such a way that the adversarial monitoring of balances between payment channels gets transformed from fine-grained processing into coarse-grained collection, hence guaranteeing that more powerful adversaries will fail at properly retrying accurate balances between two payment channels points of the Lightning Network I DON'T GET THIS

Simulate a Lightning network with this functionality

Longitudinal analysis of probed node balances

Loop In and Loop Out can already be used to change the capacity of the channel, I think without being able to see this on-chain. That makes a BDA twice as hard, because you know have to probe for the balance on both sides. I NEED TO CHECK THIS IN SIMNET! UPDATE 20190729: THIS IS NOT TRUE, capacity doesn't change accoridng to Alex Bosworth https://github.com/lightninglabs/loop/issues/66

NOTES FROM METHOD:
BELOW IS OLD STUFF


The heuristics to detect a Balance Disclosure Attack as proposed by Herrera-Joancomarti [@Herrera-Joancomarti2019] were implemented.

The BOLT #2 protocol:

Channel size:

Heuristic 1
From the perspective of node *A*:
- the rate of payment request from node B
- node *B* has just one channel

Heuristic 2
Sequential requests with a suspicious amount pattern that conforms to the minmaxBandwidth algorithm

The fact that a node has just a single channel is easily circumvented by opening up several channels with other nodes. The rate of payment requests does seem a more thorough heuristic.

Writing order vs. document order
Document order:
1. Title
2. Abstract
3. Keywords
4. Introduction
5. Method
6. Results
7. Discussion
8. Conclusions
9. Acknowledgements
10. References

Writing order
0. Figures & tables, algorithms
5. Methods
6. Results
7. Discussion
8. Conclusion
4. Introduction
  background
  problem statement
  objectives
  contributions
2. Abstract
1. Title
3. Keywords
9. Acknowledgments
10. References


 Explain BOLT protocol

Explain HTLC

Onion routing

Software approach vs protocol approach Herrera-Joancomarti used



-->
</div>