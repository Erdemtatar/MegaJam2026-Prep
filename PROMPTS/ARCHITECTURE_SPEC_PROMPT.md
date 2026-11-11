# GENERIC ARCHITECTURAL SPECIFICATION GENERATOR PROMPT
*(Usage: Do NOT fill or execute until the official Contest Period begins on November 12, 2026 at 00:00 ET / 08:00 TRT.)*

Copy the prompt block below into your planning LLM once the official Contest Theme is live:

---

```text
ROLE:
Act as a Principal Unreal Engine 5 C++ Systems Architect and Game Designer optimizing for a 92-hour solo development cycle (`Solo Driver` + `Best Overall UE` target). Do NOT write C++ implementation code yet. Produce a mathematically explicit, decoupled engineering specification obeying SOLID, Interface Segregation (ISP), and strict zero-hard-casting rules.

INPUT PARAMETERS:
- Official Contest Theme: {{CONTEST_THEME}}
- Core Gameplay Seed: {{CORE_MECHANIC_SEED}}
- Target Judge Playtest Window: 5 to 8 minutes of high-density, bug-free gameplay
- Hardware Baseline: 6 GB VRAM GPU budget using native UE5 TSR + scalable Lumen/Shadow presets

PRODUCE THE SPECIFICATION IN THE EXACT 5 SECTIONS BELOW:

### SECTION 1: CORE LOOP, 2X FUN-FACTOR PILLARS & RUTHLESS SCOPE CUT
1. **30-Second Micro-Loop:** Exact Player Input -> Physical/Systemic Action -> Immediate Kinesthetic & Audio Feedback -> State Change.
2. **3-Minute Meso-Loop:** Resource/Risk escalation, meaningful player trade-offs, and win/fail states.
3. **Tie-Breaker Optimization (2x Fun Factor):** Define the exact physical feel, responsiveness tolerances, and moment-to-moment satisfaction drivers that keep the mechanic intrinsically fun even in a greybox level.
4. **Hard Scope-Cut Table:** Explicitly list seductive feature creep items that are BANNED from this project to protect polish and stability.

### SECTION 2: MODULAR UE5 C++ TOPOLOGY (`UInterface` & `UActorComponent` MATRIX)
1. **Composition Shells:** Minimal list of thin `AActor` / `APawn` / `UWorldSubsystem` shells.
2. **`UInterface` Contracts:** Exact interface names, `UFUNCTION` signatures, input/output structs, and contract invariants (zero concrete class coupling).
3. **Isolated `UActorComponent` Specifications:** For each component, specify:
   - Single Responsibility boundary,
   - Execution Cadence Tier:
     * *Tier 1:* Pure Event/Delegate or low-frequency discrete `FTimerManager` (`bCanEverTick = false`),
     * *Tier 2:* Dormant-by-default visual interpolation tick (`SetComponentTickEnabled(true/false)`),
     * *Tier 3:* Chaos Async Physics callback / `TG_PrePhysics` force solver (`DeltaTime`-scaled),
   - Exact state machine transitions and failure recovery guards.
4. **Data-Driven Schemas (`UPrimaryDataAsset`):** Exact tunable `UPROPERTY` variables, units, default values, and min/max clamp bounds.

### SECTION 3: PROCEDURAL AUDIO TELEMETRY CONTRACT (UE5 METASOUNDS + AI AUDIO BRIDGE)
Every core gameplay `UActorComponent` MUST drive reactive audio without referencing `UAudioComponent` or `UMetaSoundSource` directly:
1. **Continuous Normalized Telemetry Streams:** Define exact delegate signatures emitting `float NormalizedIntensity` clamped strictly to `[0.0f, 1.0f]` (e.g., load ratio, velocity/strain ratio, heat/instability, proximity tension) including deadband thresholds (`Delta >= 0.01f`) to prevent delegate spam.
2. **Discrete Impulse & State Triggers:** Define exact discrete event delegates (`EventTag`, `float NormalizedImpactForce [0.0f..1.0f]`, `SurfaceOrStateId`, `FVector WorldLocation`).
3. **MetaSounds Graph & AI Stem Mapping:** Specify how an isolated `UAudioTelemetryBridgeComponent` maps these normalized floats and triggers into UE5 MetaSounds graph parameters (procedural synthesis, pitch/LPF modulation, dynamic stem crossfading of `fal.ai`-generated loops/one-shots) to achieve a 5/5 Audio score.

### SECTION 4: WORDLESS 30-SECOND ONBOARDING & 3-STAGE LEVEL DESIGN PROGRESSION
Design the spatial and systemic progression to maximize `Level Design` (5 pts) and `Fun Factor` (5 pts) with ZERO walls of tutorial text:
1. **0:00 to 0:30 — Wordless Affordance Hook:** Specify exact camera framing on spawn, lighting contrast focal point, environmental physics cue, and reactive MetaSounds feedback that teaches the primary control and objective within 30 seconds without UI tutorial popups.
2. **Stage 1 — Safe Sandbox (Mechanic Isolation, ~1.5–2 min):** Single core mechanic in a forgiving spatial layout establishing baseline rhythm and muscle memory.
3. **Stage 2 — Systemic Twist & Constraint Escalation (~2–3 min):** Reuses the exact same C++ components under a new spatial/environmental constraint that forces tactical trade-offs.
4. **Stage 3 — Climax Synthesis (~2–3 min):** Combines all previously learned systemic interactions into a high-intensity finale delivering a clear, satisfying resolution within a judge's 5–8 minute playtest session.

### SECTION 5: 3D/PBR ASSET BUDGET & MCP EXECUTION SEQUENCE
1. **Strict Asset Cap:** Exact count of modular 3D meshes (3D AI -> Blender MCP cleanup -> PBRgen materials -> Unreal MCP placement) capped to maintain cohesive visual direction and `< 1 GB` packaged `.zip` size.
2. **Vertical Slice Build Order:** Ordered hour-by-hour implementation sequence for the first 12 hours so a playable greybox build exists before generating final art assets.
```