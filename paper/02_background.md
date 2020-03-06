Background
==========

A formal analysis of privacy in the context of PCNs has been hindered by a lack of a rigorous definition of the PCN protocols, the absence of a threat model, and the ambivalent interpretations of the concept of anonymity [@Malavolta2017].

A threat model is necessary to perform a formal analysis of privacy in the setting of trustless PCNs. Malavolta [-@Malavolta2017] describes a threat model with four notions of interest:

- Balance security: participants don't run the risk of losing coins to a malevolent adversary.
- Serializability: executions of a PCN are serializable as understood in concurrency control of transaction processing, i.e. for every concurrent processing of payments there exists an equivalent sequential execution.
- (Off-path) value privacy: malicious participants in the network cannot learn information about payments they aren't part of.
- (On-path) relationship anonymity: given at least on honest intermediary, corrupted intermediaries cannot determine the sender and the receiver of a transaction better than just by guessing.

Balance Discovery Attack 
------------------------
In the basic scenario for channel balance discovery [@Herrera-Joancomarti2019] it is assumed that there is an open payment channel $AB$ between Alice, $A$, and Bob, $B$, with capacity $C_{AB}$. The goal of the adversary, Mallory, $M$, is to discover the balances of each node in channel $AB$: $balance_{AB}$ and $balance_{BA}$. To do so Mallory opens up a channel with Alice (see [@fig:simple]).

<div id="fig:simple">
\tikzset{
    auto,node distance =1 cm and 1 cm,semithick,
    state/.style ={circle, draw, minimum width = 0.9 cm}
}
\begin{tikzpicture}
  \node[state] (m) at (0,0) {$M$};
  \node[state] (a) [right =of m] {$A$};
  \node[state] (b) [right =of a] {$B$};
  \path (m) edge (a);
  \path (a) edge (b);
\end{tikzpicture}

Basic BDA were the adversary Mallory tries to disclose the balance between Alice and Bob
</div>

Mallory tries to to disclose $balance_{AB}$ by routing invalid payments through $M \leftrightarrow A \leftrightarrow B$, using the basic BDA algorithm. The inputs parameters for the algorithm are the target node $B$, the route to the target node, the value range to search in, given by 0 and $C_{AB}$, and the required accuracy for the algorithm. The algorithm creates invalid payments by using random, invalid payment hashes for each payment. The value for each payment follows a binary search pattern for which the initial lower and upper bounds are given by the value range input.

Bob, the recipient of the payment, is the only one who can determine that a payment from Mallory is invalid. Therefore, receiving an error stating the payment hash is invalid, means that $balance_{AB}$ was sufficient to route the payment, because if it was not, Alice would have returned an error stating insufficient funds and Bob would never have known about the payment. This fact is leveraged by updating the lower bound of the binary search to the value of the last payment. If however the failure message states insufficient funds, the upper bound is updated with the value of the last payment. This process repeats itself recursively until the difference between the upper bound and the lower bound of the binary search is within the threshold set by the accuracy input. The algorithm returns a tuple that gives the range within which $balance_{AB}$ sits. Since the capacity of the channel $C_{AB}$ is known, the $balance_{BA}$ can be calculated with $balance_{BA} = C_{BA} - balance_{AB}$.

By periodically executing a BDA, an adversary van monitor balances over time. This allows for tracing transactions. Therefore, this type of attack poses a threat for the value privacy as described in the threat model above.
