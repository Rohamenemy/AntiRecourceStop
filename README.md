🔐 FiveM Advanced Anti-Dump & Resource Integrity System

A high-level server-side security framework designed to protect FiveM servers against dumpers, resource manipulation, trigger abuse, callback spoofing, and client-side tampering.
It uses dynamic code delivery, live integrity monitoring, heartbeat validation, and Discord webhook reporting to keep your server transparent, traceable, and resistant to common exploit methods.

✨ Features Overview
🔸 Dynamic Two-Phase Code Injection

The server sends security code to the client in two separate phases.
This makes static dumping, reverse-engineering, and simple script extraction significantly harder.

🔸 Trigger & Callback Exploit Defense

Blocks:
— Fake ESX callbacks
— Replayed triggers
— Multiple request attempts
— Manipulation of the anti-dump process
Any violation results in an immediate, logged server-side drop.

🔸 Real-Time Resource State Monitoring

The client continuously scans all resources and reports any that are not in a started state.
The server compares this data against other players to detect local tampering or hidden resources.

🔸 Heartbeat / Freeze Protection

A lightweight heartbeat system detects:
— Thread blocking
— Client freezes
— Disabled security loops
— Stopped anti-cheat code
Missing heartbeats trigger an automatic removal.

🔸 Full Discord Logging (Webhook)

All critical security events are reported to Discord with rich embeds:
• Player kicks/drops
• Resource manipulation alerts
• Callback exploit detections
• Tampering events
• Heartbeat timeout warnings
Each log includes player name, Steam identifier, server ID, reason, and timestamp.

🔸 Server-Side First Design

The server never trusts client-side data.
All critical checks, comparisons, and decisions occur strictly server-side.

🔸 Lightweight, Clean & ESX Compatible

Fast to integrate, minimal configuration, and no external dependencies — just drop it into your server.

⚙️ How It Works

Player requests the initial script from the server.

Server verifies legitimacy and sends the first phase of the loader.

The client uses a secure callback to request phase two.

Server validates this request and sends the monitoring code.

Client reports resource states and sends regular heartbeats.

Server validates reports, cross-checks players, and logs any issues.

Confirmed manipulation results in a clean, documented kick.

📌 Ideal For

— Protecting server files from dumpers
— Detecting stopped/hidden resources
— Blocking trigger & callback spoofing
— Monitoring suspicious client behavior
— Strengthening your security layer without relying on a full anti-cheat

🛡️ Security Notes

This system adds a strong barrier, but no client-side protection is perfect.
For maximum protection, combine this with:
• server-side validation
• obfuscation
• resource integrity checks
• anti-cheat modules

✅ Summary

A polished, production-ready FiveM Anti-Dump framework combining dynamic injection, integrity monitoring, cross-player verification, heartbeat security, and Discord logging — designed to secure your server with speed, clarity, and transparency.
