# GLASS BOX ENGINEERING DEV LOG — [PROJECT TITLE PLACEHOLDER]

> **Compliance & Formatting Rules Before Publishing (Delete this callout before final export):**
> - **100% English Required** across all text, diagrams, and captions.
> - **ZERO Third-Party Trademarks/Logos:** Do NOT embed any third-party tool logos, GPU vendor badges, IDE icons, or browser tabs in screenshots. Crop strictly to clean UE5 viewport/graph/architecture views or plain-text ASCII/Mermaid diagrams. Mention external tools solely in plain text for transparency and compliance disclosure.
> - **Daily Time Cap:** Spend no more than 10 minutes at the end of each block filling out one Milestone Card below.

---

## 1. TRANSPARENCY & RULES COMPLIANCE DECLARATION

- **Category & Team Structure:** Solo Entrant (`Solo Driver` / `Best Overall: Unreal Engine` / `Glass Box`)
- **Pre-Contest Generic Tooling Repository (Rule 7(h)):** `[Repository URL & Final Commit SHA prior to Contest Period]` — Contains exclusively theme-agnostic ignore rules, C++ architectural constraints, MetaSounds/Level Design prompt templates, and a generic `RunUAT` packaging script.
- **Game Production Timeline:** Initial `.uproject`, game design, C++ gameplay code, MetaSounds graphs, levels, and AI-generated assets were created strictly after `November 12, 2026, 00:00 AM ET`.
- **Sourced (Non-Original) Assets Declaration (Rule 1(d) & Rule 15(c)):**
  - `[List exact non-AI external sourced assets here if any were used, OR state: "None. All gameplay code, 3D meshes, PBR textures, audio stems, and procedural MetaSounds graphs were created during the Contest Period using UE5 native tools and the AI pipeline documented below."]`

### AI & Automation Pipeline Matrix

| Production Layer | Tooling Used (Plain Text) | Human Engineering & Architectural Control |
| :--- | :--- | :--- |
| **Systems Architecture & Math Specs** | Gemini (Argon / Carbon) | Defined SOLID/ISP boundaries, `UInterface` contracts, failure modes, and scope cuts before code generation. |
| **UE5 C++ Implementation** | Antigravity IDE + Rider | Enforced zero hard-casting, 3-tier tick/physics isolation, `TObjectPtr` safety, and manual code review. |
| **Scene & Asset Automation** | Unreal MCP + Blender MCP | Automated pivot normalization (`1 unit = 1 cm`), decimation, collision setup, and batch actor placement. |
| **3D Mesh & PBR Material Generation** | Hyper3D Rodin, Tripo, Meshy, PBRgen | Directed silhouette prompts, normalized texel density/roughness maps, and unified lighting response in UE5. |
| **Concept & 2D UI Reference** | fal.ai | Generated styleboards and clean, trademark-free HUD iconography references. |
| **Hybrid AI + Procedural Audio** | fal.ai + UE5 MetaSounds | Generated raw audio layers/stems via AI and wired them into real-time reactive UE5 MetaSounds graphs driven by normalized C++ component telemetry. |

---

## 2. ARCHITECTURAL FOUNDATION: TAMING AI CODE GENERATION

### Decoupled Component & Interface Topology
`[Insert clean Mermaid diagram or cropped architecture diagram here — NO third-party logos]`

- **Core Architectural Constraint:** Every mechanic was isolated into standalone `UActorComponent` and `UWorldSubsystem` units communicating strictly over `UInterface` contracts and multicast delegates.
- **Why This Mattered for AI Agents:** Blocking cross-class `Cast<>` calls prevented the coding agent from creating circular header dependencies and allowed individual components to be regenerated or refactored without breaking adjacent systems.
- **Execution Tier Discipline:**
  - *Tier 1 (Event/Delegate):* `[List state/UI/rule components running at 0.0ms idle cost]`
  - *Tier 2 (Toggled Interpolation Tick):* `[List kinematic smoothing components toggled via SetComponentTickEnabled]`
  - *Tier 3 (Chaos Physics / PrePhysics):* `[List continuous force/simulation components]`

---

## 3. CHRONOLOGICAL ENGINEERING LOG (92-HOUR MILESTONES)

### Milestone 01 — Core Greybox & C++ Vertical Slice (Day 1)
- **Timestamp (ET):** `2026-11-12 [HH:MM ET]`
- **Engineering Problem:** `[1-2 sentences on turning the Contest Theme into a testable physical/systemic greybox loop]`
- **Prompt / MCP Workflow Executed:** `[Summarize architectural specification prompt + initial component generation]`
- **AI Failure Mode & Human Override:** `[Document specifically where the LLM hallucinated an API, misused a timer/tick, or produced bad game feel, and the exact C++ architectural fix you enforced]`
- **Evidence:** `[Clean UE5 greybox viewport screenshot — cropped, no external logos]`

### Milestone 02 — 3D Asset & PBR Pipeline via Blender/Unreal MCP (Day 2)
- **Timestamp (ET):** `2026-11-13 [HH:MM ET]`
- **Engineering Problem:** `[Maintaining consistent scale, clean topology, collision primitives, and unified PBR lighting across AI-generated meshes]`
- **Prompt / MCP Workflow Executed:** `[Hyper3D Rodin / Tripo / Meshy generation -> Blender MCP scale/pivot/decimation script -> PBRgen material maps -> Unreal MCP import]`
- **AI Failure Mode & Human Override:** `[e.g., Fixing non-manifold geometry, inverted roughness values, off-center pivots, or excessive triangle counts]`
- **Evidence:** `[Clean wireframe vs. lit UE5 viewport comparison screenshot]`

### Milestone 03 — Reactive Audio Telemetry & Wordless 3-Stage Level Design (Day 3)
- **Timestamp (ET):** `2026-11-14 [HH:MM ET]`
- **Engineering Problem:** `[Teaching mechanics within 30 seconds without text walls, and making AI-generated audio react dynamically to continuous gameplay physics]`
- **Prompt / MCP Workflow Executed:** `[Generating base audio layers on fal.ai + wiring C++ [0.0..1.0] normalized component telemetry delegates into UE5 MetaSounds]`
- **AI Failure Mode & Human Override:** `[e.g., Smoothing noisy physics telemetry with deadbands/interpolation before feeding pitch/filter modulation in MetaSounds; tuning Stage 1 -> Stage 3 spatial pacing]`
- **Evidence:** `[Clean UE5 MetaSounds graph screenshot + level progression top-down layout]`

### Milestone 04 — Native TSR Optimization, Scalability & Packaging Audit (Day 4)
- **Timestamp (ET):** `2026-11-15 [HH:MM ET]`
- **Engineering Problem:** `[Guaranteeing smooth frame pacing within a 6 GB VRAM envelope, hardware-agnostic compatibility across judge GPUs, and a < 1 GB standalone Windows build]`
- **Engineering Actions Taken:** `[Configured UGameUserSettings Low/Med/High/Epic presets with native UE5 TSR screen percentage scaling, verified MapsToCook, stripped .pdb symbols, and tested standalone zip on clean paths]`
- **Evidence:** `[Clean in-game "stat unit" / frame-time capture]`

---

## 4. PERFORMANCE & PACKAGING TELEMETRY

| Metric | Measured Result (Development / Shipping Win64, 1080p Native TSR) |
| :--- | :--- |
| **Average Frame Time / FPS** | `[XX.X ms / XXX FPS]` |
| **Peak VRAM Allocation** | `[X.XX GB (within 6 GB target budget)]` |
| **Final Compressed `.zip` Size** | `[XXX MB (< 1 GB itch.io standalone target)]` |
| **External Runtime Dependencies** | `Zero third-party upscalers; UE5 prerequisites bundled via -prereqs` |

---

## 5. POST-MORTEM: WHAT WORKED VS. WHAT WAS CUT
- **Architectural Wins:** `[2-3 bullet points on modular C++ components + MCP velocity]`
- **Deliberate Scope Cuts:** `[2-3 bullet points on features cut early to protect Fun Factor and polish]`