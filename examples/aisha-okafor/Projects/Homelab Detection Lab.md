<!-- Fictional example persona for Jobbee (jobbee.io). Not a real person; numbers invented. CC-BY-4.0, see repo LICENSE. -->

# Homelab detection lab

Personal project, April 2020 to now, in a closet at home in Atlanta. On my resume it's one line under "Outside work". It's where I learned detection engineering before anyone paid me for it, and later where I taught myself web application security.

## Why

In early 2020 I was a tier 1 analyst. I could triage an alert, but I'd never seen the attack that produced one. Lanternwatch's training lab was shared and reset every week. I wanted one where I could run attacks, keep the evidence and write the rule.

## What's in it

- One used rack server ($410), a managed switch ($95) and a UPS: about $650 in hardware. Power runs about $20 a month.
- Proxmox as the hypervisor.
- A small Windows domain: one domain controller, three Windows endpoints, one Ubuntu web server.
- Sysmon on every Windows host, shipping into Elasticsearch and Kibana. Wazuh since 2022.
- Atomic Red Team to run attack techniques on demand, mapped to MITRE ATT&CK.
- Since 2024, a web tier behind a reverse proxy: OWASP Juice Shop, DVWA, and a small Go API I wrote with 6 planted bugs, including missing ownership checks, a SQL string built by hand, and a token compared with `==`.

I built and run all of it alone. The outside help was public documentation and the Sigma community's published rules, which is how I learned the format.

## How it went

- 2020–2021, detection. For each technique I ran the Atomic test, looked at what Sysmon recorded, and wrote a Sigma rule. 11 of the 34 rules I wrote for Lanternwatch's shared library started here.
- 2022–2023: maintenance and OSCP practice. The domain became my Active Directory range.
- 2024 on, AppSec. When I took over application security at Tillgrove, I needed code I was allowed to break to write Semgrep rules against. The first versions of 6 of my 22 Tillgrove rules were written and tested on the Go API. It's also where I practiced for the Burp Suite certification.

## The numbers

- 58 Sigma rules, covering 46 ATT&CK techniques.
- Each rule tested against its Atomic test plus 2 variants I wrote by hand: 174 test cases, run as a script after every change.

## What went wrong

- I exposed Kibana to the internet for 4 days in June 2021, through a router port forward protected by basic auth only, so I could check dashboards from work. My own external scan found it. The auth logs showed about 1,900 failed logins and no successful one. I removed the forward within the hour. Remote access has been WireGuard only since, with nothing forwarded. It was a small version of the exact mistake I was paid to catch for clients.
- My early rules were overfitted to the test. My first encoded-PowerShell rule matched the exact `-EncodedCommand` flag the Atomic test used; attackers write `-enc`, `-e`, or mixed case. A Lanternwatch reviewer threw a real variant at it when I adapted it. Since then every rule gets 2 hand-written variants before it's done, and I write the variants first. If I can't think of 2, I don't understand the technique yet.
- I spent about 3 months in 2020 on an ATT&CK coverage dashboard I never looked at again. The test script was the useful part.
- I lost the early 2020 rule history to a disk failure and rebuilt it from exports. Everything has been in version control since.

None of this was assigned. It's why my SOC-era rules shipped with tests before that was normal at Lanternwatch.

## What's still open

Nothing in the lab is half-done. It has no finish line: it's practice space I keep running, and the 174 test cases still run after every change.
