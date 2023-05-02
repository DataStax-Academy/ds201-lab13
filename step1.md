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
 <a href='command:katapod.loadPage?[{"step":"intro"}]'
   class="btn btn-dark navigation-top-left">⬅️ Back
 </a>
<span class="step-count"> Step 1 of 2</span>
 <a href='command:katapod.loadPage?[{"step":"step2"}]' 
    class="btn btn-dark navigation-top-right">Next ➡️
  </a>
</div>

<!-- CONTENT -->

<div class="step-title">Do an INSERT with no active replicas</div>

✅ Check that all three nodes are up and running:

```
./node1/bin/nodetool status
```

✅ Use `nodetool getendpoints` to determine which nodes hold the replicas for the cassandra partition tag value in the *videos_by_tag* table:
```
./node1/bin/nodetool getendpoints killrvideo videos_by_tag 'cassandra'
```

✅ Stop both of the replica nodes for the *cassandra* partition by running `nodetool stopdaemon`:

---
**Note:** The way the cluster, datacenters and keyspace are organized means that the replicas will either be *node1* & *node3* or node2 & node3.

After shutting the replicas down either *node1* or *node2* will still be running.

---

<details class="katapod-details">
  <summary>Solution</summary>

Make sure that you only shut down two replica nodes!
<table class="katapod-table">
  <tr>
    <th>Node (IP)</th>
    <th>Shutdown command</th>
  </tr>
  <tr>
    <td>127.0.0.1</td>
    <td>

```
./node1/bin/nodetool stopdaemon
``` 
</td>
<tr>

  <tr>
    <td>127.0.0.2</td>
    <td>

```
./node2/bin/nodetool stopdaemon
``` 
</td>
<tr>
    
<tr>

  <tr>
    <td>127.0.0.3</td>
    <td>

```
./node3/bin/nodetool stopdaemon
``` 
</td>
<tr>

</table>

Keep track of which nodes you shut down and also the node number that is still up.

</details>
<br>

✅ Start *cqlsh* and connect to the remaining online node:
<table class="katapod-table">
  <tr>
    <th>Node (IP)</th>
    <th>cqlsh command</th>
  </tr>
  <tr>
    <td>127.0.0.1</td>
    <td>

```
./node1/bin/cqlsh
``` 
</td>
<tr>

  <tr>
    <td>127.0.0.2</td>
    <td>

```
./node2/bin/cqlsh
``` 
</td>
<tr>

</table>

✅ Switch to the *killrvideo* keyspace and set the consistency level to `ANY`:
<details class="katapod-details">
  <summary>Solution</summary>

```cql
USE killrvideo;

CONSISTENCY ANY;
```

</details>
<br>

When a client writes with consistency `ANY`, storing a hint on the coordinator node is sufficient for the write to be successful. Consistency `ONE` requires that at least one successful write to a replica node - a hint is not sufficient.

✅ Execute the following INSERT statement to add a new row to the videos_by_tag table:
```cql
INSERT INTO videos_by_tag (tag, added_date, video_id, title)
VALUES ('cassandra', '2020-04-07', uuid(), 
'Cassandra, Take Me Home');
```

The write will succeed even though both replica nodes for the *cassandra* partition are down! The one and only node left in the cluster stores the writes as *hints* for the two replica nodes until they come back online.

✅ QUIT *cqlsh*:
```cql
QUIT
```

<!-- NAVIGATION -->
<div id="navigation-bottom" class="navigation-bottom">
 <a href='command:katapod.loadPage?[{"step":"intro"}]'
   class="btn btn-dark navigation-bottom-left">⬅️ Back
 </a>
  <a href='command:katapod.loadPage?[{"step":"step2"}]' 
    class="btn btn-dark navigation-top-right">Next ➡️
  </a>
</div>
