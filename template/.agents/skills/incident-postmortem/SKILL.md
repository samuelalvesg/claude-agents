---
name: incident-postmortem
description: Generates blameless post-mortem analysis from incidents, regressions, or production bugs. Focuses on root cause, timeline, contributing factors, and preventive measures.
---
# Principles
- Blameless culture: Analyze system flaws, missing safeguards, and process gaps, never individual human error.
- Fact-driven: Base timeline and causal factors strictly on logs, metrics, telemetry, and commit history.
- Actionable outcomes: Every identified contributing factor must produce a preventive task, alert, or automated test.

# Structure
1. **Summary**: Brief description of the incident, impact (downtime, data loss, affected users), and duration.
2. **Timeline (UTC)**: Sequential events from onset to detection, mitigation, and full resolution.
3. **Root Cause Analysis (5 Whys)**: Deep causal chain leading to the underlying systemic failure.
4. **Trigger & Blast Radius**: What specifically triggered the failure and what components were affected.
5. **Detection & Response**: How the incident was identified (automated alerts vs user reports) and effectiveness of playbooks.
6. **Action Items (Preventive Safeguards)**:
   - Type (Test | Monitoring | Architecture | Process) | Action | Owner | Priority

# Output
Standard markdown document saved under `docs/incidents/YYYY-MM-DD-incident-title.md`.
