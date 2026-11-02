<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Ransomware on the night shift

Lanternwatch Security, the night of February 16–17, 2022. I was the tier 3 night lead. On my resume it's one bullet. This file is the timeline, the decisions, and the suppression rule of mine that hid the early warning.

## The setup

The client was a manufacturer with about 450 people, two plants in the Carolinas, 212 endpoints and 41 servers. We had their EDR, firewall and VPN logs under a managed detection contract. We did not run their backups or their network; their IT director and one sysadmin did. Our runbook for this client pre-authorized two actions without a phone call: isolating a host through the EDR, and disabling an account in their identity provider. Anything bigger needed the IT director. My crew was one tier 1 and one tier 2 analyst, with the day-side incident response team on call by phone.

## The timeline

All times Eastern.

- 23:31: a VPN login for a service account, from a hosting provider's network we had never seen for this client. Nothing alerted on it. The account had no MFA.
- 23:58: the EDR flagged a process reading LSASS memory on a jump host, the classic first step of credential theft. A suppression rule closed it automatically. I had written that rule in January.
- 01:47: the EDR fired on mass file renames on file server FS02, then on FS01, then on an application server, APP03.
- 01:51: the tier 1 escalated and I took it. Every file was getting the same new extension. I treated it as ransomware from that minute.
- 01:58: isolated FS02 through the EDR. 02:04: isolated FS01 and APP03.
- 02:05: called the client's IT director and woke him up.
- 02:10: working back from FS02's first malicious process, I found the 23:31 VPN session. 02:16: disabled the service account. 02:22: the client's sysadmin blocked the 2 command-and-control addresses we'd pulled from EDR telemetry at their firewall.
- 02:31: no new encryption events on any host for 10 minutes. I called it contained, and we kept watching.
- 07:00: handed over to the day IR team with a written timeline of 61 entries.

## The decision that mattered

At 02:12 the IT director asked whether he should pull the internet connection for both plants. It would have worked, and it would have stopped production, because the plants' manufacturing system ran over the link between the two sites. Encryption was confined to 3 isolated servers, and the attacker's way in was being shut. I recommended per-host isolation, the account disable and the firewall block, with a check every 10 minutes and a clear trigger: one new encryption event anywhere and we pull the link. It was his call; he took the recommendation, and the plants kept running.

## My role

I owned the night's calls and the timeline. The day IR team owned forensics and full scoping; the client owned the restore and their own communications. Attribution was never part of our contract.

## The numbers

- 44 minutes from the first encryption alert (01:47) to containment (02:31).
- 3 of 41 servers encrypted, 0 endpoints.
- 31 hours to restore all 3 from the client's offline backups. About 6 hours of file changes lost on one share: the gap between the 19:30 backup and the encryption.
- No ransom paid. Root cause, confirmed by the client: a service account without MFA, with a password reused from a breached site.

## My mistake

The 23:58 alert. In January the client's backup software was reading LSASS on the backup server and the jump host every night, and it was flooding tier 1. I wrote a suppression for it, and I scoped it to the host group and the access type instead of to the backup agent's signed binary. So any process reading LSASS on those hosts got closed automatically, including the attacker's. With a correct rule we'd have had almost 2 hours of warning before the first file was encrypted.

It cost us again later that night. Because the alert was closed, I never looked at the jump host. The day team found a scheduled task there at 11:00, set to run the encryptor again at 03:00 the next night. It never ran, and that was luck as much as anything.

## What changed afterwards

I led the audit of the shared library's 140 suppression rules. 23 were over-broad the way mine was; 9 were removed and 14 narrowed. The new standard for every suppression: an expiry date, a second reviewer, and a test showing that a malicious process doing the same thing still fires.

My own habits changed too. I scope a suppression to a signed binary or a hash, never to a host group. Before calling anything contained, I check every host the attacker's account touched, including hosts with no open alert. And we had flagged MFA for service accounts in this client's quarterly report months earlier; a sentence in a report isn't pushing.

I still write suppressions, because noise burns analysts out, but I treat each one as code that can hide an attack. The same rule covers Semgrep suppressions at Tillgrove today.
