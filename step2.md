<!-- TOP -->
<div class="top">
  <img class="scenario-academy-logo" src="https://datastax-academy.github.io/katapod-shared-assets/images/ds-academy-2023.svg" />
  <div class="scenario-title-section">
    <span class="scenario-title">Hinted Handoff</span>
    <span class="scenario-subtitle">ℹ️ For technical support, please contact us via <a href="mailto:academy@datastax.com">email</a>.</span>
  </div>
</div>

<!-- NAVIGATION -->
<div id="navigation-top" class="navigation-top">
 <a href='command:katapod.loadPage?[{"step":"step1"}]'
   class="btn btn-dark navigation-top-left">⬅️ Back
 </a>
<span class="step-count"> Step 2 of 2</span>
 <a href='command:katapod.loadPage?[{"step":"finish"}]' 
    class="btn btn-dark navigation-top-right">Next ➡️
  </a>

</div>

<!-- CONTENT -->

<div class="step-title">See hints in action</div>

✅ View the *hints* directory for the running node:

<table class="katapod-table">
  <tr>
    <th>Node (IP)</th>
    <th><i>ls</i> comand</th>
  </tr>
  <tr>
    <td>127.0.0.1</td>
    <td>

```
ls -l ./node1/data/hints
``` 
</td>
<tr>

  <tr>
    <td>127.0.0.2</td>
    <td>

```
ls -l ./node2/data/hints
``` 
</td>
<tr>
</table>

```
### {"execute": false}
total 8
-rw-r--r-- 1 ubuntu ubuntu 318 Apr  7 08:11 b6f8e8ca-b0ae-48f7-855e-98ebbe97d153-1586247113080-v1.hints
-rw-r--r-- 1 ubuntu ubuntu 447 Apr  7 08:11 c4eb8051-ea98-49bc-bb5f-96dbad73a1cd-1586247113076-v1.hints
```

You should see that the node is storing hints. You can also run ls multiple times to see the hints files grow larger over time. The first part of the file name should correspond with the *Host ID* of the node that hints are being saved for.

✅ Run the ls command on the other nodes’ hints directory and check that they are empty (meaning neither of the offline nodes are storing hints).

✅ Start *cqlsh* on the running node:

✅ Verify that the consistency level is set back to the default of `ONE`:

<details class="katapod-details">
  <summary>Solution</summary>

```cql
node1/bin/cqlsh

CONSISTENCY;
```
</details>
<br>

✅ Execute the following SELECT statement to try the read back the new row:
```cql
SELECT * FROM killrvideo.videos_by_tag WHERE tag = 'cassandra';
```

The query fails with `NoHostAvailable`: because the sole online node is not a replica node for the *cassandra* partition, i.e. it does not own the part of the token range that *cassandra* would hash to. 

✅ Quit *cqlsh* and start *node3*:
```
QUIT

./node3/bin/cassandra
```

Wait for *node3* to start.

✅ Run `ls` on the *hints* directory of the non-replica node like you did before:

```
### {"execute": false}
total 288
-rw-r--r-- 1 ubuntu ubuntu 293255 Apr  7 08:13 c4eb8051-ea98-49bc-bb5f-96dbad73a1cd-1586247113076-v1.hints
```
You will see that one of the set of hint files has disappeared. This is due to this node forwarding the hints to *node3* after it has come back online.


✅ Start cqlsh again and connect to *node3*:
```
./node3/bin/cqlsh
```

✅ Switch to the *killrvideo* keyspace and `SELECT` the *cassandra* partition

<details class="katapod-details">
  <summary>Solution</summary>

```cql
USE killrvideo;

SELECT * FROM killrvideo.videos_by_tag WHERE tag = 'cassandra';
```

</details>
<br>

The query succeeds and returns the new row.

✅ Quit *cqlsh*:
```
QUIT
```

✅ Start the remaining node:

✅ Run `ls` on the *hints* directory of the non-replica node like you did before:

You should see no more hints since they have been passed to the two replicas nodes.

<!-- NAVIGATION -->
<div id="navigation-bottom" class="navigation-bottom">
 <a href='command:katapod.loadPage?[{"step":"step1"}]'
   class="btn btn-dark navigation-bottom-left">⬅️ Back
 </a>
  <a href='command:katapod.loadPage?[{"step":"finish"}]' 
    class="btn btn-dark navigation-top-right">Next ➡️
  </a>

</div>
