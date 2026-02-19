# AI Appointment Setter: 24/7 Dental Clinic Receptionist 🦷

> **The Problem**: 60% of dental leads go cold within 5 minutes. This AI Agent responds in <10 seconds, qualifies patients, and books appointments autonomously via WhatsApp—converting "Lead Zombies" into confirmed revenue.

## 📊 Business Impact
- **Response Time**: <10 seconds (vs. 2-4 hours industry average)
- **Conversion Rate**: [TU MÉTRICA] leads → confirmed appointments
- **Availability**: 24/7, including weekends and holidays
- **Human Time Saved**: [ESTIMACIÓN] hours/week

---

## 🎯 What It Does (The "So What?")

**Before**: Patient messages clinic → waits hours → forgets → books elsewhere  
**After**: AI qualifies pain/urgency → checks real calendar → books appointment → syncs to Google Calendar

### Live Demo
| Conversation 1/2 | Conversation 2/2 | GCal Appointment |
| :---: | :---: | :---: |
| <img src="img/whatsapp_conversation1.png" width="200"> | <img src="img/whatsapp_conversation2.png" width="200"> | <img src="img/gcal_appointment.png" width="200"> |

---

## 🏗️ Architecture Highlights (The "How?")

### 1. Intelligent Session Management
```
┌─ New lead? → Create conversation + memory
├─ Returning lead? → Resume from last state  
└─ Human intervened? → AI automatically pauses
```
- **Tech**: PostgreSQL + PostgresChatMemory
- **Why it matters**: Zero context loss, even across days

### 2. Human-in-the-Loop Safety Gate
```python
if lead.paused_by_human:
    return None  # AI steps back, no overlap
```
- **Why it matters**: Staff can take over anytime, AI knows when to stop

### 3. Real-Time Tool Use (Function Calling)
The AI doesn't just chat—it *acts*:
- `consultar_disponibilidad` → Queries Google Calendar API
- `confirmar_cita` → Books appointment + sends confirmation
- `buscar_informacion_clinica` → RAG over clinic FAQ (Postgres pgvector)

**Model**: Gemini 2.0 Flash (chosen for speed + tool use reliability)

### 4. Smart Scheduling Logic
- Parses natural language: "mañana por la tarde" → 15:00-19:00 range
- Respects business rules: No bookings on Sundays, 30-min slots only
- Conflict detection: Won't double-book existing appointments

---

## 🛠️ Technical Stack

| Layer | Technology | Why This Choice |
|-------|-----------|-----------------|
| **Orchestration** | n8n | Rapid prototyping + visual debugging |
| **AI Brain** | Gemini 2.0 Flash | Best speed/cost for function calling |
| **Memory** | PostgreSQL + pgvector | Structured data + semantic search |
| **WhatsApp Bridge** | EvolutionAPI | Official API support + webhooks |
| **Calendar** | Google Calendar API | Direct integration, no middleware |

---

## 🚀 Production Considerations

### Current Limitations (MVP Phase)
- Single-threaded conversation handling
- No A/B testing framework for prompt variations
- Limited analytics dashboard

### Migration Roadmap: Python-Core Architecture
```
n8n (Current) → FastAPI + LangGraph (Target)
```
**Why migrate?**
- Complex branching logic (multi-condition routing)
- Horizontal scalability (handle 100+ concurrent chats)
- Advanced observability (LangSmith tracing)
- Easier CI/CD integration

**ETA**: When clinic scales beyond 500 leads/month

---

## 💡 Key Innovation: The "Lead Zombie" Killer

**Industry Problem**: 
- Average response time: 2-4 hours
- 60% of leads book elsewhere within 24 hours

**This Solution**:
- Response time: <10 seconds
- Qualification + booking in single conversation
- No lead goes unanswered (even at 2 AM)

---

## 📸 Workflow Deep Dive

![n8n Workflow Mastery](img/chatbot_full_workflow.png)

**Key Flow Stages:**
1. **Webhook Reception** → EvolutionAPI receives WhatsApp message
2. **Lead Detection** → Check if phone exists in DB
3. **Context Loading** → Retrieve conversation history + memory
4. **Pause Check** → Verify human hasn't taken over
5. **AI Processing** → Gemini decides: chat, search FAQ, or check calendar
6. **Response Routing** → WhatsApp reply or calendar booking
7. **State Persistence** → Save updated conversation state

---

## 🎓 What I Learned Building This

1. **LLMs need guard rails**: The pause logic prevents AI from "talking over" humans
2. **Tool calling ≠ Magic**: Spent 40% of dev time on tool schemas and error handling
3. **Memory is harder than it looks**: Balancing context window vs. retrieval precision
4. **Production ≠ Prototype**: Added retry logic, rate limiting, and fallback responses

---

## 📬 Want to Discuss?
This system is production-ready for clinics handling 50-500 leads/month. For enterprise-scale deployments, I'm building the FastAPI version with advanced routing and analytics.

[LinkedIn] | [Email] | [Calendar Booking Tool (dogfooding my own AI 😄)]








### 1. Conversational AI Logic
The agent follows a strict medical protocol: Greet -> Qualify Pain/Need -> Check Availability -> Confirm Identity -> Finalize Booking.
![WhatsApp AI Conversation](img/whatsapp_chatbot_conversation.png)

### 2. Full Workflow Architecture
A robust end-to-end pipeline with state management and database logging.
![n8n Workflow Mastery](img/n8n_chatbot_workflow.png)

### 3. Real-Time Scheduling Success
The ultimate goal achieved: A confirmed appointment automatically placed in the clinic's Google Calendar without human intervention.
![Calendar Confirmation](img/chatbot_appointment_confirmed.png)

## 🚀 The "Python-Core" Roadmap
While this n8n-based version is fully functional for MVP stages, the architecture is designed to migrate its "brain" to a dedicated **FastAPI + LangGraph** microservice. This will allow for more complex branching logic and industrial-scale concurrency as the SaaS scales.

---
*Note: This system solves the "Lead Zombie" problem by responding in <10 seconds, ensuring no patient inquiry goes unanswered.*
