# Recommendations for STYLE.MD

This file is a working cheat sheet for improving `STYLE.MD` while preserving its strict declarative direction.

## Main positioning

- State scope at the top of `STYLE.MD`.
- Make it explicit that the document is **not** a universal Go standard.
- Say clearly that it is the **code style policy for this repository** and for projects created from this template.

Suggested wording:

> This is not a general Go style guide.
> This is the code style policy for this repository and its derived template-based projects.

## What to improve next

1. Keep the philosophy, improve the editorial structure.
2. Separate **principles** from **derived rules**.
3. Make every rule easier to apply during review.
4. Finish incomplete content sections before polishing examples.
5. Preserve strictness, but anchor it in repository policy and rationale.

## Recommended document structure

Possible top-level structure:

1. Scope
2. Core principles
3. API design rules
4. Exporting rules
5. Documentation rules
6. Testing rules
7. Formatting rules
8. Decision rule for uncovered cases

## Core editing rule

For each rule, prefer the same structure:

1. Rule
2. Why
3. Bad
4. Good
5. Notes / exceptions

Even if exceptions are rare, this shape keeps the document predictable and easier to scan.

## Principle -> rule hierarchy

Make the causal chain more explicit:

- declarative style -> fewer hidden changes
- immutability -> easier reasoning
- explicit package APIs -> simpler review and reuse
- constructors without side effects -> more predictable object creation
- domain types -> clearer business model

This helps the guide read as a coherent system instead of a list of commands.

## High-priority content tasks

- Add a `Scope` section near the top.
- Finish `Funcs return only one value`.
- Add the missing `No nil` section if it stays in TLDR.
- Check that every TLDR item has a real section in the body.
- Check that every completed `✅` block is truly content-complete.

## Keep the tone, sharpen the framing

- It is okay to stay strict.
- Prefer framing rules as **repository policy** rather than universal truth about Go.
- Use strong wording when needed, but make the purpose obvious.
- When a rule is non-negotiable, make that clear directly.

Examples:

- Good: `In this template, setters are prohibited.`
- Good: `In this template, constructors do not return errors.`
- Less effective: `Setters are evil.`

## Make rules reviewable

Each rule should be easy to verify in a pull request.

Ask:

- What exactly is forbidden?
- What exactly is required?
- What code shape should a contributor produce instead?
- Can a reviewer detect compliance quickly?

If a rule is hard to verify, refine its wording.

## Suggested non-negotiable core

Consider extracting a short list of the most important rules:

1. Prefer declarative design over imperative control-heavy style.
2. Avoid mutable APIs such as setters.
3. Prefer immutable objects after construction.
4. Use explicit package APIs.
5. Keep constructors simple and free from side effects.
6. Use domain-specific types where they improve clarity.
7. Document public behavior clearly.
8. Cover behavior with tests.

## Decision rule for edge cases

Add a short closing fallback such as:

> If a case is not covered explicitly, prefer the option that preserves declarative design, immutability, and explicit package APIs.

This gives contributors a way to act when no exact example exists yet.

## Later cleanup pass

After the content is stable:

1. Fix Go syntax and code example correctness.
2. Fix English wording and grammar.
3. Check consistency of section names, TLDR labels, and terminology.
4. Map rules to enforcement:
   - lint
   - tests
   - code review only

## Reminder

- `✅` in TLDR means the block is content-complete, even if the Go examples are not finalized yet.
- Do not optimize examples too early if the rule itself is still evolving.
