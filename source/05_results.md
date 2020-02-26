Results
=======

We confirmed the improvements provided by the two-way probing algorithm in two ways. Firstly we confirmed the feasibility of the algorithm in our local testing cluster. Secondly we have analyzed the LN running on top of Bitcoin mainnet, to estimate the number of channels that can have their balances disclosed by this algorithm and compare this to the earlier version of this attack.

Local Network Evaluation
------------------------

We ran the Two-way Probing algorithm with every possible permutation of clients. By analyzing the responses from the clients, and analyzing the code of the respective clients on GitHub, we found that not every client implemented the \textsc{MAX\_PAYMENT\_ALLOWED} the same way.

On May 23rd, 2017 the BOLT specification was changed [^commit] by Paul "Rusty" Russel, who authored the majority of the BOLT documents. The variable containing the payment amount, amount_msat, was changed from a 32 bit unsigned integer to a 64 bit unsigned integer. This meant that before that change it was impossible to create a payment bigger than $2^{32} - 1$ whatsoever, but after that change in theory it was possible to create bigger payments. Additional specifications required the sending node to set the four most significant bytes of amount_msat to 0. But those additional requirements aren't implemented equally by the three main clients.

C-lightning is the only client that fully adheres to the requirements. Eclair has a limit of $5 \cdot 10^9 msat$. LND doesn't verify the for the each RPC. By using the unverified RPC in our algorithm we could send fake payments up to the maximal channel capacity. This meant that we can disclose any balance between two LND Nodes, even if the balance is above the upper limit of the two-way probing algorithm. In the scenario's where Alice is a LND node and Bob is an Eclair node or both are Eclair nodes, balances up to $5 \cdot 10^9 msat$ can be disclosed without making use of two-way probing.

In the case where Alice is a LND node and Bob is a C-lightning node, we saw interesting behavior of the C-lightning node which turned out to be a vulnerability of the current LN that can be exploited.

[^commit]: https://github.com/lightningnetwork/lightning-rfc/commit/068b0bccf94e8cdaf5f298dade0fcc8cc8421ef6#diff-3369c5aa1774fef2ff1e246979f223eaR590

Payment of Death
----------------
If a C-lightning node is being requested to route a payment to another node, or is the receiver of a payment, with an amount that his higher than \textsc{MAX\_PAYMENT\_ALLOWED}, it decides to fail the channel with the requesting node and close down that channel. Since LN uses onion routing, the requesting node from the perspective of the c-lightning node, is the one that comes just before it in the route. But that isn't necessarily the node from which the payment originated.

Consider the basic scenario (see [@fig:simple]), where Mallory and Alice run LND, and Bob runs c-lightning. Both channels between Mallory and Alice and between Alice and Bob have balances that allow for payments bigger than the \textsc{MAX\_PAYMENT\_ALLOWED} limit. If Mallory would create a fake payment with an amount above that limit, Bob would close down it's channel with Alice, without Alice being able to mitigate this in any way. We coined the term Payment of Death for this attack, after the infamous Ping of Death.

We have notified the developers of the LN implementations by means of a responsible disclosure.

Channels affected
-----------------

The two-way probing algorithm works regardless of the client software. So we can look at the channel capacity of all public channels in the LN graph and determine the proportion of channels that are now susceptible to this type of attack based on a snapshot of the network taken on the 3rd of October, 2019 (see [@fig:capacity]).

<div id="fig:capacity">
\scalebox{0.7}{
    \begin{tikzpicture}
    \begin{axis}[
        xlabel={Channels (sorted by increasing capacity)},
        ylabel={Percentage of Channels},
        width=\textwidth,
        xmin=0, xmax=16777215,
        ymin=0, ymax=100,
        ytick={0,20,40,60,80,100},
        legend pos=south east,
        ymajorgrids=true,
        grid style=dashed,
        label style={font=\normalsize},
        tick label style={font=\normalsize}  
    ]
    
    \addplot[
        color=blue,
        mark=none,
        ultra thick,
        each nth point=5
        ]
        table {source/data/capacity.dat};
    \legend{Cum. perc. of Channels};

    \draw [dashed, draw=red] 
        (axis cs: 4294967,0) -- node[below=5pt, font=\small, sloped] {$MAX\_PAYMENT\_ALLOWED$} (axis cs: 4294967,100);

    \draw [dashed, draw=red] 
        (axis cs: 8589934,0) -- node[below=5pt, font=\small, sloped] {$2 \times MAX\_PAYMENT\_ALLOWED$} (axis cs: 8589934,100);

    \end{axis}
    \end{tikzpicture}
}
Cumulative percentage graph of payment channels ordered by increasing capacity. $MAX\_PAYMENT\_ALLOWED$ shows the percentage of channels with disclosable balances using the basic BDA algorithm. $2 \times MAX\_PAYMENT\_ALLOWED$ shows the percentage of channels with disclosable balances using the two-way probing algorithm.
</div>

To estimate the number of channels susceptible for Balance Disclosure above the $2^{33}$ limit set by the Two-way algorithm, we need to know the type of client on either side of a channel. There's no known way of figuring out what kind of client is installed, but if you know the proportion of each client type in the LN, it is possible to estimate the amount of channels for each specific combination of clients.

We queried 1ML for each node in our snapshot of the LN. We identified the client type for 273 nodes out of 3608 and estimated the proportion of nodes running different clients based on that data. (See [@tbl:proportions])

\footnotesize
|   Client    |  n   | Proportion (%) |  CI[^CI] (%)  |
| :---------- | ---: | -------------: | :-----------: |
| LND         |  220 |          80.59 | (79.35-81.83) |
| c-lightning |   40 |          14.65 | (13.54-15.76) |
| Eclair      |   11 |           4.03 |  (3.41-4.65)  |
| Other       |    2 |           0.73 |  (0.47-1.00)  |

Table: Proportion of nodes running different Lightning clients {#tbl:proportions}

[^CI]: 95% Confidence interval

\normalsize

The amount of channels that are susceptible to the Payment of Death, can now be estimated with the following analysis.

The LN is a graph $G$, with the number of vertices $n = \left | G(V) \right |$ and the number of edges $m = \left | G(E) \right |$.
Our analysis yielded the following values for n and m:

$n = 3608$
$m = 9438$ with $1086$ channels having a capacity greater than $2^{32}$ and $540$ channels having a capacity greater than $2^{33}$.

The client software defines the type of the vertex. $type_l$ for LND nodes, $type_c$ for c-lightning nodes and $type_e$ for Eclair nodes.
An edge is said to be of $type_{(l, c)}$ if it connects a $type_l$ vertex and a $type_c$ vertex. The graph is without self-loops and undirected, so edge $type_{(l, c)} \equiv type_{(c, l)}$.
Since we know the proportions of the different vertex types we can calculate the probability of an edge being of a specific type

\small
- $P(type_{(l, l)}) = 0.8059^2$
- $P(type_{(c, c)}) = 0.1465^2$
- $P(type_{(e, e)}) = 0.0403^2$
- $P(type_{(l, c)}) = 2 \times 0.8059 \times 0.1465$
- $P(type_{(l, e)}) = 2 \times 0.8059 \times 0.0403$
- $P(type_{(c, e)}) = 2 \times 0.1465 \times 0.0403$

\normalsize
Assuming vertex type and channel capacity have a covariance of zero, the number of edges of each edge type, having a capacity greater than $2^{33}$ is calculated as follows: $P(type_{([c, e, l], [c, e, l])}) \times 540$. We are interested in the $type_{(l, l)}$ and $type_{(l, e)}$ channels, because the  $type_{(l, c)}$ channels are susceptible to the Payment of Death, which doesn't allow for discovering the balance. So the amount of channels with a capacity above $2^{32}$ is $540 \times P(type_{(l, l)}) + 540 \times P(type_{(l, e)}) = 386$ channels. So a total of $9438 - 540 + 386 = 9284$ channels have balances that can be disclosed. This is 98.4% of all channels.

For the amount of channels affected by the POD we are interested in all $type_{(l, c)}$ channels, with a balance above \textsc{MAX\_PAYMENT\_ALLOWED}. This is $1086 \times P(type_{(l, c)}) = 256$ channels, meaning that 2.7% of all channels can be shutdown by using malformed payments.
