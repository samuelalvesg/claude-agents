---
name: tool-contract-design
description: Designs reliable, safe, and robust tool contracts (MCP / CLI tools) with explicit input schemas, strict validation, and structured error responses.
---
# Contract Design Principles
1. **Explicit Schemas**: Use JSON Schema / strong types for all inputs and outputs.
2. **Deterministic Inputs**: Require explicit paths or IDs; reject ambiguous wildcard or freeform prompts where precise inputs are expected.
3. **Idempotency**: Tools performing state changes must support idempotency or return clear current-state indicators.
4. **Structured Error Handling**: Return actionable error codes and failure explanations, not unhandled stack traces or generic 500s.
5. **Least Privilege & Security**: Sanitize path parameters against path traversal (`../`); prevent arbitrary shell evaluation.

# Contract Structure
- **Tool Name**: Verb-Noun identifier (e.g. `get_database_schema`, `run_query`).
- **Input Parameters**: Type, description, default value, required status.
- **Output Schema**: JSON structure or exact return format.
- **Error Conditions**: Expected failure modes and corresponding error responses.
