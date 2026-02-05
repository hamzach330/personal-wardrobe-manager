# Personal Wardrobe Manager – Project Idea & Initial Plan

## 1. Product Vision
- Build an agentic mobile companion that manages the user’s wardrobe, recommends weather/event-ready outfits, and guides shopping decisions with confident sizing suggestions.
- Emphasize personalization (measurements, fit notes, usage history), local context (weather, nearby stores), and privacy-first data handling.
- MVP goal: become the user’s daily “What should I wear/buy?” assistant with a delightful onboarding-to-outfit experience.

## 2. Personas & Pain Points
| Persona | Needs | Pain Points |
| --- | --- | --- |
| Style Seeker (urban professional) | Inspiring daily outfits, event-ready looks | Time-consuming planning, inconsistent styling |
| Practical Planner (busy parent) | Organized closet, laundry/reminder support | Scattered wardrobe info, underused items |
| Fit-Frustrated Shopper | Size confidence before buying | Brand-to-brand size variance, returns fatigue |

## 3. Value Pillars
1. **Personal Wardrobe Intelligence** – Inventory + metadata (category, fabric, care, weather tags) with usage analytics.
2. **Contextual Guidance** – Weather/location/calendar-aware outfit planning and nudges.
3. **Fit Confidence** – Measurements, historical fit feedback, retailer size charts/local availability.
4. **Delight & Trust** – On-device reasoning where possible, transparent recommendations, optional cloud sync.

## 4. Key KPIs
- 30-day retention ≥ 45%
- Weekly active sessions ≥ 3 per user
- Outfit acceptance rate ≥ 50%
- Wardrobe capture completion ≥ 80% of owned items
- Shopping conversions (affiliate clicks → purchases) as monetization signal
- Fit satisfaction CSAT ≥ 4/5

## 5. Feature Roadmap (Phased)
### Phase 0 – Foundations
- Account setup, secure auth.
- Measurement capture (manual + guided flow).
- Wardrobe intake (camera, auto-tagging, manual labels).
- Location & weather permission flow.
- Simple “What to wear today” card.

### Phase 1 – Agentic Core
- Contextual outfit engine (weather, calendar, laundry status).
- Fit notes logging + learning loop.
- Wardrobe gap detection & reminders.
- Push notifications / daily digest.

### Phase 2 – Shopping Assist
- Retailer catalog ingestion (APIs, affiliate feeds).
- Size-chart matching + fit confidence explanation.
- Local store availability & pickup/reserve actions.
- “Why this item?” insight panel.

### Phase 3 – Network & Premium
- Shareable lookbooks / stylist sessions.
- Cross-device sync, premium laundry scheduler, packing lists, AR try-on experiments.

## 6. Data Model Sketch
- `UserProfile`: measurements, preferences, climate band.
- `Garment`: metadata, images, fit_notes, availability.
- `Outfit`: linked garments, context rules satisfied, recommendation rationale.
- `Event`: calendar import, dress code, location.
- `WeatherSnapshot`: cached daily/hourly data for reasoning.
- `StoreItem`: brand, size_map, stock, location.
- `InteractionLog`: outfit feedback, shopping conversions, reminders.

## 7. Technical Architecture
- **Client**: React Native (Expo) for iOS/Android parity; on-device caching for offline wardrobe.
- **Backend**: Supabase/Firebase for auth + storage; Node/TypeScript service for orchestration; vector DB (pgvector/Pinecone) for garment embeddings.
- **Integrations**: Weather (Tomorrow.io/WeatherKit), retailer APIs (Shopify, Walmart, Nordstrom), maps (Mapbox), calendar import.
- **AI Layer**: Rule-based + LLM agent with tools (wardrobe DB, weather fetch, store search) and RAG grounding for transparent recommendations.
- **Security**: Encrypted image storage (S3/Supabase Storage with KMS), user-controlled sync, audit logging for recommendation actions.

## 8. Delivery Milestones (12-week MVP)
1. **Weeks 1–2** – Customer discovery, finalize MVP scope, define schema, set up repo/CI.
2. **Weeks 3–5** – Implement onboarding, measurement capture, wardrobe intake UI + backend.
3. **Weeks 6–8** – Weather/calendar integration, rules-based outfit engine, feedback logging.
4. **Weeks 9–10** – Agent UI (chat/cards), personalization loop, notifications, analytics instrumentation.
5. **Weeks 11–12** – Shopping alpha (single retailer), usability testing, polish, TestFlight/closed beta.

## 9. Next Steps
- Flesh out onboarding screens in Figma (“Main Page”); include welcome, permissions, measurement setup, wardrobe intake intro, preferences, summary.
- Validate data/API availability for fit intelligence and local store inventory.
- Draft API contracts for wardrobe, outfit, and shopping endpoints.
- Plan user research sessions to confirm personas and refine KPIs.
