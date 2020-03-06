Method
======

In order to research the role of LN client software in BDA we must first determine which LN clients are available. We used 1ML Lightning Network Search and Analysis Engine[^1ml] to estimate respective proportions of each client in LN. 1ML is a website that publishes the current state of the LN graph and allows for node owners to self-report on a voluntary basis the type of client they use.

We chose the three LN clients with the largest network share to run a local cluster of LN nodes, each node running one of three supported clients. All LN nodes used Bitcoin Core's Bitcoind implementation as the Bitcoin backend. Bitcoind ran in regression testing mode, known as regtest mode. This is a local test mode, making it possible to almost instantly create blocks with no real world value. Using regtest mode, the different implementations could be tested without incurring transaction fees for the on-chain transactions and without having to wait for blocks to be mined.

On this cluster we analyzed the basic and improved algorithm having the LN nodes in each possible permutation of supported clients. This helped us determine if the new algorithm was to be considered an improvement and whether client differences could play a role in BDA.

[^1ml]: https://1ml.com/

Two-way channel probing
-----------------------

The original algorithm [@Herrera-Joancomarti2019] is bound by an upper limit set by \textsc{MAX\_PAYMENT\_ALLOWED}. This limit makes it impossible to probe balances that are higher than $2^{32} - 1\,msat$. This paper proposes an improved algorithm.

Consider a channel $AB$ with capacity $C_{AB}$. Since $C_{AB} = C_{BA} = balance_{AB} + balance_{BA}$, the following holds

$C_{AB} < 2^{33} \implies min\left \{ balance_{AB}, balance_{BA} \right \} < 2^{32}$

For all channels with a capacity $C_{AB} < 2^{33}$ there's always a balance lower than  $\frac{2^{33}}{2} = 2^{32}$ on one end of the channel. With this knowledge we can extend the algorithm by letting it probe the channel from the other side, once we assess that the balance is higher than \textsc{MAX\_PAYMENT\_ALLOWED} on the initial probing side. This setup requires an optional second channel from the adversary Node M to Node B, to be able to probe the channel between Node A and Node B from the side of Node B. (See [@fig:twoway])

<div id="fig:twoway">
\tikzset{
    auto,node distance =1 cm and 1 cm,semithick,
    state/.style ={circle, draw, minimum width = 0.9 cm},
    optional/.style={dashed},
}
\begin{tikzpicture}
  \node[state] (m) at (0,0) {$M$};
  \node[state] (a) [below left =of m, xshift=0.4cm] {$A$};
  \node[state] (b) [below right =of m, xshift=-0.4cm] {$B$};
  \path (m) edge[bend right=20] (a);
  \path (a) edge[bend right=20] (b);
  \path[optional] (m) edge[bend left=20] (b);
\end{tikzpicture}

Basic scenario with an optional second channel for two-way probing
</div>

Algorithm \ref{twowayProbing} describes BDA with optional two-way probing for channels with a capacity above \textsc{MAX\_PAYMENT\_ALLOWED}. Algorithm \ref{twowayProbing} takes the same input parameters as the basic algorithm and returns the same tuple.

If $C_{AB}$ is higher than than \textsc{MAX\_PAYMENT\_ALLOWED}, the algorithm will try to send a fake payment with a size of exactly \textsc{MAX\_PAYMENT\_ALLOWED}. If that payment is possible, we have assessed that we are on the wrong end of the channel for probing the balance. The algorithm now calls itself with the target node and the final node of the route switched. The algorithm assumes that there's a route from the adversary to this new target node. The return value of that call is $balance_{BA}$, for calculating $balance_{AB}$ we use the following formula:

$balance_{AB} = C_{BA} - balance_{BA}$

If $C_{AB} > MAX\_PAYMENT\_ALLOWED \land C_{AB} < 2 \times  MAX\_PAYMENT\_ALLOWED$, the value of the first payment will not be exactly in the middle of the value range for the binary search, since it will use the fixed value of \textsc{MAX\_PAYMENT\_ALLOWED} for the first payment. That makes this algorithm slightly less computationally efficient then a perfect binary search, but it minimizes the use of the optional second channel.

\begin{algorithm}
\caption{Two-way Probing}\label{twowayProbing}
\begin{algorithmic}[1]
\Require route, target, maxFlow, minFlow, accuracy\_treshold
\Ensure bwidth, an array of tuples that gives the range of bandwidth discovered for each channel
\State $missingTests \gets True$
\State $bwidth.max \gets maxFlow$
\State $bwidth.min \gets minFlow$
\State $channelCapacity \gets getInfo(target).capacity$
\While{missingTests}
  \If{$bwidth.max - bwidth.min \leq accuracy\_threshold$}
    \State $missingTests \gets False$
  \EndIf
  \If{$bwidth.max \geq 2^{32}$}
    \State $flow \gets 2^{32} - 1$
  \Else
    \State $flow \gets (bwidth.min + bwidth.max) / 2$
  \EndIf
  \State $h(x) \gets RandomValue$
  \State $response \gets sendFakePayment(route = [route, target], h(x), flow)$
  \If{$response = UnknownPaymentHash$}
    \If{$bwidth.min < flow$}
      \State $bwidth.min \gets flow$
    \EndIf
  \ElsIf{$response = InsufficientFunds$}
    \If{$bwidth.max > flow$}
      \State $bwidth.max \gets flow$
    \EndIf
  \EndIf
  \If{$bwidth.min = 2^{32} - 1$}
    \State $newTarget \gets route.pop()$
    \State $route \gets route.push(target)$
    \State $bwidthBA \gets twowayProbing(route, newTarget, bwidth.min, 0, accuracy\_treshold)$
    \State $bwidth.min \gets channelCapacity - bwidthBA.max$
    \State $bwidth.max \gets channelCapacity - bwidthBA.min$
    \State $missingTests \gets False$
  \EndIf
\EndWhile
\State \textbf{return} $bwidth$
\end{algorithmic}
\end{algorithm}
