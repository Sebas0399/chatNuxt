# Product

<!-- impeccable:product-schema 1 -->

## Platform

web

## Users
CRM users, customer success managers, and sales operators who need to configure, build, and deploy conversational chatbot interfaces to automate customer communication and bridge workflows with their CRM platform.

## Product Purpose
To provide an extremely easy-to-use, visual chatbot constructor and tester. It exists to let CRM users build chatbots and connect them to their operational backend services. Success means frictionless bot setup, intuitive visual flow building, and effortless chat testing.

## Positioning
A lightweight, high-productivity web companion designed for rapid bot construction. It is distinguished by its direct connection to CRM workflows, visual flow editor, and a universal capability to integrate with any external REST API trigger or endpoint.

## Operating Context
A modern web dashboard used inside browser tabs alongside active CRM dashboards, sales tools, and customer databases. The system handles active chat sessions, custom bot listings, flow charts, and company account configurations.

## Capabilities and Constraints
- **Framework & Routing:** Nuxt v4 (`app/` directory) with Pinia state management.
- **UI Components & Theme:** PrimeVue (v4.3.7) styled with Tailwind CSS, utilizing the Aura preset.
- **Visual Workflows:** Node-based editor implemented using `@vue-flow/core`.
- **Backend Integrations:** Calls backend endpoints relative to `http://localhost:8080`.
- **Routing Boundaries:** Includes pages for authentication (`/login`), home/dashboard (`/`), list and creation of bot types (`/bots`), visual node editing (`/flows`), testing active conversations (`/chat`), and company configuration (`/company`).

## Brand Commitments
- **Theme:** PrimeVue Aura preset theme.
- **Assets:** Custom SVG logo inside the master navigation menubar.
- **Voice:** Direct, operational, and professional.

## Evidence on Hand
- **Incumbent Pages:** Established templates for all core flows under `app/pages/`.
- **Existing API base:** Default backend base URL at `http://localhost:8080`.

## Product Principles
- **API First Simplicity:** Every bot or flow trigger should easily consume and send data to any API endpoint without complex code.
- **Intuitive Visual Builder:** Branching and chatbot flows should be entirely visual and clear to non-technical CRM administrators.
- **Instant Sandbox Feedback:** Testing bots and checking responses should happen instantly within a live preview sandbox context.

## Accessibility & Inclusion
- Fully compliant with standard keyboard navigation and semantic HTML, inherited and enhanced via PrimeVue elements and Tailwind focus/interactive utilities.
