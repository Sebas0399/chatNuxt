---
name: chatNuxt Chatbot Builder
description: Flat, high-productivity visual workspace for automated CRM chatbot design.
colors:
  primary: "#0d9488"
  primary-hover: "#0f766e"
  primary-active: "#115e59"
  neutral-bg: "#fafafa"
  neutral-card: "#ffffff"
  border: "#e4e4e7"
  text-primary: "#18181b"
  text-secondary: "#71717a"
typography:
  display:
    fontFamily: "Inter, system-ui, -apple-system, sans-serif"
    fontSize: "2.25rem"
    fontWeight: 700
    lineHeight: "2.5rem"
  headline:
    fontFamily: "Inter, system-ui, -apple-system, sans-serif"
    fontSize: "1.5rem"
    fontWeight: 600
    lineHeight: "2rem"
  title:
    fontFamily: "Inter, system-ui, -apple-system, sans-serif"
    fontSize: "1.25rem"
    fontWeight: 600
    lineHeight: "1.75rem"
  body:
    fontFamily: "Inter, system-ui, -apple-system, sans-serif"
    fontSize: "0.875rem"
    fontWeight: 400
    lineHeight: "1.25rem"
  label:
    fontFamily: "Inter, system-ui, -apple-system, sans-serif"
    fontSize: "0.75rem"
    fontWeight: 500
    lineHeight: "1rem"
rounded:
  sm: "6px"
  md: "8px"
  lg: "12px"
spacing:
  xs: "4px"
  sm: "8px"
  md: "16px"
  lg: "24px"
  xl: "32px"
components:
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "#ffffff"
    rounded: "{rounded.md}"
    padding: "8px 16px"
  button-primary-hover:
    backgroundColor: "{colors.primary-hover}"
  card-container:
    backgroundColor: "{colors.neutral-card}"
    rounded: "{rounded.lg}"
    padding: "24px"
---

# Design System: chatNuxt Chatbot Builder

## Overview

**Creative North Star: "The Operational Canvas"**

The chatNuxt visual system is a high-productivity workspace tailored specifically for CRM users who build, manage, and monitor automated chatbots. Structured like an interactive diagram board, it trades heavy graphics and deep gradients for fluid node-based flows, tactile sandbox controls, and perfect readability. It acts as an operational desk where the data and chatbot structures are the main characters.

The design relies on a flat, containerized structure utilizing crisp borders and high contrast rather than heavy atmospheric layering. Interactions are immediate, direct, and predictable, ensuring CRM administrators can configure complex API actions and conversation routes without feeling visually overwhelmed.

**Key Characteristics:**
- **Flat Surface Separation:** Solid containers separated by crisp borders to manage dense data panels.
- **Micro-tactile Highlights:** Color is used extremely sparingly, acting only as a functional signpost for interactive actions and focused connections.
- **Structured density:** High informational density optimized for quick parsing and rapid layout navigation.

## Colors

The color palette is built entirely around professional teal accents and slate-zinc grays to emphasize a productive, enterprise-grade workspace.

### Primary
- **Enterprise Teal** (#0d9488): A focused, tech-forward, and trustworthy deep teal representing the primary brand character. It is reserved exclusively for primary actions, focused interactive nodes, active triggers, and positive indicators.

### Neutral
- **Crisp Canvas** (#fafafa): The primary system background. A clean, clinical paper surface that keeps cognitive load low.
- **Card White** (#ffffff): Used for content containers, node cards, and active page sheets to draw focus above the main canvas.
- **Border Zinc** (#e4e4e7): Used to outline cards, tables, input fields, and panels.
- **Text Zinc Primary** (#18181b): Dark, solid carbon gray used for high-readability copy, labels, and headlines.
- **Text Zinc Secondary** (#71717a): Medium slate-gray for auxiliary details, descriptions, and placeholder text.

### Named Rules
**The Rarity of Teal Rule.** Enterprise Teal is used on 10% or less of any single screen. Its primary job is to guide the user's focus toward completion points, active routes, and main actionable triggers.

**The No-Faux-Glass Rule.** No backdrops, translucent overlays, or blurred cards are allowed. Surfaces are solid, flat colors to maintain the crisp, high-performance canvas aesthetic.

## Typography

**Display Font:** Inter, sans-serif (system fallbacks)
**Body Font:** Inter, sans-serif (system fallbacks)
**Label/Mono Font:** System Monospace

The typography uses a clean, neutral sans-serif with a compact, geometric structure, optimized for fast legibility of dense form fields and flow labels.

### Hierarchy
- **Display** (700, 2.25rem / 36px, 2.5rem): Used for major dashboard banners or high-level status highlights.
- **Headline** (600, 1.5rem / 24px, 2rem): Used for primary section titles and list pages.
- **Title** (600, 1.25rem / 20px, 1.75rem): Used for component headers, modal headers, and sidebar titles.
- **Body** (400, 0.875rem / 14px, 1.25rem): Default text. Compact but highly readable with a maximum width of 65ch inside documentation and descriptions.
- **Label** (500, 0.75rem / 12px, 1rem): Used for field labels, table headers, node triggers, and technical metadata.

## Layout

The page layout is structured as a split pane dashboard or interactive canvas.
- **Navigation Menubar:** Fixed to the top with a subtle bottom border (#e4e4e7), serving as a persistent home anchor.
- **Split Workspaces:** Left sidebars are used for navigation or element lists, while the central canvas is reserved for primary activities (like flow builders or testing chats).
- **Grid Spacing:** Spacing utilizes a base-4 system (4px, 8px, 16px, 24px, 32px), with a standard gap-4 (16px) spacing between cards, widgets, and form groups to keep elements cohesive.

## Elevation & Depth

This system avoids ambient lighting and atmospheric depth in favor of flat tonal layering.

- **At Rest:** Elements are entirely flat against the canvas. Container boundaries are defined by a crisp 1px solid Border Zinc (#e4e4e7).
- **Interactive State:** Shadows appear only as a micro-elevation reaction during a drag or hover interaction to signify tactility.

### Shadow Vocabulary
- **Tactile Drag** (`box-shadow: 0 4px 12px rgba(13, 148, 136, 0.1)`): A soft, focused teal-tinted shadow used exclusively when dragging a flow node or hovering over a primary card.
- **Action Float** (`box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05)`): A generic subtle shadow applied to active context menus and popover cards.

### Named Rules
**The Flat-By-Default Rule.** All workspace panels, cards, and nodes are completely flat at rest. Spatially separate layers are communicated through solid borders and varying background weights, not drop-shadow gradients.

## Shapes

The form language is based on high precision, using small, disciplined rounded corners that balance friendly usability with professional density.

- **Buttons & Small Controls:** Gently curved edges with a 6px rounded corner radius (`rounded.sm`) for a sharp, high-precision look.
- **Cards, Nodes, & Inputs:** A solid 8px rounded corner radius (`rounded.md`) to encase functional data groups.
- **Major Panels & Modals:** A generous 12px rounded corner radius (`rounded.lg`) for top-level interactive layers.

## Components

### Buttons
- **Shape:** Gently curved corners (6px / 8px).
- **Primary:** Filled with Enterprise Teal (#0d9488) and white text. Padding is exactly 8px top/bottom and 16px left/right.
- **Hover / Focus:** Transitions smoothly (150ms ease) to Deep Teal (#0f766e) on hover, and applies a subtle focus ring on active navigation focus.
- **Secondary / Ghost:** Transparent background with Zinc-Border outline and dark text. Background transitions to light Zinc (#f4f4f5) on hover.

### Cards / Containers
- **Corner Style:** Clean 8px or 12px rounded corners.
- **Background:** Pure Card White (#ffffff) or ultra-light gray (#fafafa).
- **Border:** Outlined with a continuous 1px solid Border Zinc (#e4e4e7).
- **Internal Padding:** Spaced generously with a default md padding (16px / 24px).

### Inputs / Fields
- **Style:** Compact 1px border (#e4e4e7), solid white background, 8px rounded radius.
- **Focus:** Sharp transition to Enterprise Teal border (#0d9488) accompanied by a tight focus glow.

### Flow Nodes
- **Style:** Dual-tone card. A header strip using light gray (#f4f4f5) separated by a 1px border from a pure white (#ffffff) bottom body.
- **Interaction:** Outline turns teal (#0d9488) on hover, indicating it can be connected or modified.

## Do's and Don'ts

### Do:
- **Do** restrict Enterprise Teal (#0d9488) to focused, intentional call-to-actions, triggers, and active connections.
- **Do** use a solid 1px zinc border (#e4e4e7) on all card blocks and structural divisions to maintain flat legibility.
- **Do** present flow node metadata with monospace labels to reinforce the precise, developer-friendly "Operational Canvas" vibe.

### Don't:
- **Don't** use large, fuzzy black box-shadows. Shadows should be ultra-soft, thin, or avoided entirely in favor of clean borders.
- **Don't** mix multiple roundness settings on adjacent sibling elements; keep buttons tight (6px) and cards structured (8px).
- **Don't** add random bright colors to chatbot message bubbles; stick strictly to Enterprise Teal for active/user responses and neutral light gray for assistant responses.
