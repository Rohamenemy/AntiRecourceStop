# AntiRecourceStop
🔐 'FiveM Advanced Anti-Dump & Resource Integrity System'

A lightweight yet powerful server-side security module designed to detect and prevent common FiveM attack vectors: 'dumping', 'callback exploits', 'trigger abuse', and 'resource manipulation'. It combines dynamic client-side code injection with server-side validation and Discord webhook logging for clear, auditable alerts.

✨ 'Key Features'

'Dynamic Two-Step Code Loader'
Sends two phases of runtime code to the client: a 'First Code' initializer and a 'Second Code' runtime monitor — raising the bar for static analysis and simple dumping attempts.

'Trigger & Callback Exploit Protection'
Detects repeated/forged requests and fake ESX callbacks, and immediately removes players that attempt to manipulate or replay protected events.

'Live Resource State Scanner'
Injected client code scans resources on a short interval (e.g. every 700ms) and reports non-'started' states back to the server for verification.

'Cross-Player Consistency Check'
Server compares resource reports against other random players to reduce false positives and confirm suspicious local manipulation.

'Heartbeat / Freeze Detection'
Clients emit a lightweight heartbeat; missed heartbeats indicate blocked threads or tampering and result in server actions.

'Discord Webhook Logging'
All major events are logged to Discord with rich embeds: 'player drops', 'resource manipulation attempts', 'callback exploits', 'tampered execution', and 'heartbeat timeouts'. Logs include player name, Steam identifier (if available), server ID, reason, and timestamp.

'Server-Side Validation First'
Design principle: assume the client can lie. All trust decisions, comparisons, and punishments are evaluated server-side.

'ESX Compatible & Minimal'
Plugs into ESX, no external libraries required, and minimal configuration (webhook URL). No unnecessary comments or bloat — production-ready and easy to audit.

⚙️ 'How It Works (Overview)'

Server marks a player and sends the 'First Code' payload to create a secure callback flow.

When the client requests the 'Second Code' via ESX callback, the server verifies request state and returns runtime monitoring code.

The injected monitor reports resource states and emits periodic heartbeats.

Server receives reports, cross-checks with other players, and logs suspicious activity to Discord.

Confirmed manipulation or tampering triggers a safe, logged 'DropPlayer' action.

📌 'Use Cases'

Protect against mod menus and local resource hiding.

Detect and respond to trigger/callback replay attacks.

Gain centralized visibility (Discord) into attempted server-side integrity breaches.

Add a defensive layer without replacing a full anticheat solution.

⚠️ 'Important Notes'

Client-side checks are inherently weaker than server-side checks; this system reduces attack surface but does not make clients fully trustworthy.

Replace the webhook URL before publishing or use environment/config variables for secrets.

Consider hardening: code obfuscation, server-side resource validation, and additional telemetry for higher-security environments.

✅ 'What You Get'

A compact, auditable anti-dump pattern using 'dynamic loading', 'heartbeat', 'resource scanning', and 'Discord logging'.

Clear logging and rational server logic that’s straightforward to extend or integrate into existing infrastructures.
