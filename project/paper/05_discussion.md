Discussion
==========

Herrera-Joancomarti [-@Herrera-Joancomarti2019] reported that 89.10% of all channels could have their balances exactly disclosed. Our research showed that we can improve this to 98.37% of all channels, a 9.27 percentage point increase (See [@tbl:results]). The basic BDA performed slightly less in our snapshot of the LN network because in the period between the two snapshots of the 8th of January, 2019 and the 3rd of October, 2019, the percentage of channels with a capacity $C$ of $C > 2^{32}$ slightly increased.

\footnotesize

|       Disclosable channels       | basic BDA (%) | two-way probing BDA (%) |
| :------------------------------- | ------------: | ----------------------: |
| $C \leq 2^{32}$                  |         89.10 |                   88.49 |
| $C > 2^{32} \land C \leq 2^{33}$ |             0 |                    5.79 |
| $C \leq 2^{33}$                  |             0 |                    4.09 |
| TOTAL                            |         89.10 |                   98.37 |

Table: Percentage of channels susceptible for the basic BDA and the two-way probing BDA {#tbl:results}

\normalsize

Impact of Payment of Death
--------------------------
The properties of the vulnerability make it so that the highly capitalized nodes are more vulnerable, since it are these nodes that have channels with a balance above \textsc{MAX\_PAYMENT\_ALLOWED} limit. The average capacity of those 1086 channels is $10196116\;msat$. Using that average combined with the estimated proportions of affected channels, 17.5% of the total capacity of the network could be taken down with an organized attack. These proportions align with proportions earlier found through alternative methods [@Pérez-Solà2019]. It's reasonable to assume that these channels are responsible for routing a disproportionate amount of the payments on the network. So such an attack could have substantial impact on the ability to route payments of the network as a whole.

The closing of channels comes at a cost to the victim nodes, since you have to broadcast on-chain transactions for closing a channel and again for reopening it. Those transactions have transaction fees attached to it. Furthermore, channel age is used as heuristic for determining the reliability of a node for routing payments, so routing nodes have an incentive to keep channels open as long as possible.

Countermeasures
---------------
Clients should adhere to the BOLT specification, making it impossible to create payments with a value higher than \textsc{MAX\_PAYMENT\_ALLOWED} and deny to consider payments with a value above the \textsc{MAX\_PAYMENT\_ALLOWED} for routing. The latter would make it impossible to disclose balances above $2^{33}\,msat$. Secondly, clients shouldn't consider a malformed payment a reason for permanently closing down a channel. This would make it impossible to mount a POD attack.
